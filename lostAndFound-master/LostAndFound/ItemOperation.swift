//
//  ItemOperation.swift
//  LostAndFound
//
//  Created by Орлов Максим on 05.07.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import Foundation
import GooglePlaces
import GoogleMaps

class ItemOperation : Operation
{
    var success : (NSArray) -> Void
    var failure : (Int) -> Void
    var itemID : String
    
    var internetTask : URLSessionDataTask?
    
    init (itemID : String, success : @escaping (NSArray) -> Void, failure : @escaping (Int) -> Void)
    {
        self.success = success
        self.failure = failure
        self.itemID = itemID
    }
    
    override func cancel()
    {
        internetTask?.cancel()
    }
    
    override func main()
    {
        let semaphore = DispatchSemaphore(value: 0)
        
        internetTask = API_WRAPPER.getPost(itemID: itemID, success: {(jsonResponse) in
        
            let out = NSMutableArray()
            
            let id = jsonResponse["id"].stringValue
            let idUser = jsonResponse["iduser"].stringValue
            let itemAdress = jsonResponse["itemadress"].stringValue
            let itemDescription = jsonResponse["itemdescription"].stringValue
            let itemLatitudeStr = jsonResponse["itemlatitude"].stringValue
            let itemLongitudeStr = jsonResponse["itemlongitude"].stringValue
            let itemName = jsonResponse["itemname"].stringValue
            let itemReward = jsonResponse["itemreward"].stringValue
            
            print("Имя вещи на экране - \(itemName)")
            
            let itemLatitude = CLLocationDegrees(itemLatitudeStr)
            let itemLongitude = CLLocationDegrees(itemLongitudeStr)
            
            let itemPhotoCollectionModel = ItemPhotoCollectionModel(photosUrls: NSArray(), itemName: itemName)
            let itemHeaderModel = ItemHeaderModel(itemReward: itemReward)
            let itemMapModel = ItemMapModel(latitude: itemLatitude!, longitude: itemLongitude!, itemAdress: itemAdress)
            let itemDescriptionModel = ItemDescriptionModel(itemDescription: itemDescription)
            
            out.add(itemPhotoCollectionModel)
            out.add(itemHeaderModel)
            out.add(itemMapModel)
            out.add(itemDescriptionModel)
          
            self.internetTask = API_WRAPPER.getUser(userId: idUser, success: {(response) in
                
                let userName = response["response"]["user"]["displayName"].stringValue
                let userID = response["response"]["user"]["uid"].stringValue
                
                let itemContactModel = ItemContactsModel(itemUserId: userID, itemUserName: userName, itemUserPhoto: #imageLiteral(resourceName: "vernik"))
                
                out.add(itemContactModel)
                
                self.success(out)
                semaphore.signal()

                
            }, failure: {code in
                
                semaphore.signal()
                self.failure(code)

            
            })
            
            
        } , failure: {(error) in
            
            semaphore.signal()
            self.failure(error)
        })
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
    }

}



