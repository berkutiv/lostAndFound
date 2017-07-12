//
//  AddOperation.swift
//  LostAndFound
//
//  Created by Иван on 26.04.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import Foundation

class AddOperation : Operation
{
    var success : (String) -> Void
    var failure : (Int) -> Void
    var token : String
    var userId : String
    var itemName : String
    var itemDescription : String
    var itemLatitude : String
    var itemLongitude : String
    var itemReward : String
    var itemAdress : String
    var photos : NSArray
    
    var internetTask : URLSessionDataTask?
    
    init (token : String, userId : String, itemName : String, itemDescription : String, itemLatitude : String, itemLongitude : String, itemAdress : String, itemReward : String, photos : NSArray, success : @escaping (String) -> Void, failure : @escaping (Int) -> Void)
    {
        self.itemAdress = itemAdress
        self.token = token
        self.userId = userId
        self.itemName = itemName
        self.itemDescription = itemDescription
        self.itemLatitude = itemLatitude
        self.itemLongitude = itemLongitude
        self.itemReward = itemReward
        self.success = success
        self.failure = failure
        self.photos = photos
    }
    
    override func cancel()
    {
        internetTask?.cancel()
    }
    
    override func main()
    {
        let semaphore = DispatchSemaphore(value : 0)
        
        internetTask = API_WRAPPER.addPost(token: token, userId: userId, itemName: itemName, itemDescription: itemDescription, itemLatitude: itemLatitude, itemLongitude: itemLongitude, itemAdress: itemAdress, itemReward: itemReward, photos : photos, success: {(jsonResponse) in
        
            let data = jsonResponse["response"]
            let addSuccess = data["success"].stringValue
            
            if self.isCancelled == false
            {
                self.success(addSuccess)
            }
                
            else
            {
                self.success("")
            }
            
            semaphore.signal()

            
        }, failure: {errorCode in
            
            semaphore.signal()
            self.failure(errorCode)
        })
            
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
    }
}
