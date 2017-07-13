//
//  MapOperation.swift
//  LostAndFound
//
//  Created by Иван on 26.04.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import Foundation

class MapOperation: Operation
{
    var success: (NSArray) -> Void
    var failure: (Int) -> Void
    
    var internetTask : URLSessionDataTask?
    
    init( success: @escaping (NSArray) -> Void, failure: @escaping (Int) -> Void)
    {
        
        self.success = success
        self.failure = failure
    }
    
    override func cancel()
    {
        internetTask?.cancel()
    }
    
    override func main()
    {
        let semaphore = DispatchSemaphore(value: 0)
        internetTask = API_WRAPPER.getPosts(success: { (jsonResponce) in
            
            let posts = jsonResponce["response"]["posts"].arrayValue
            
            print("колво \(posts.count)")
            var outData = NSMutableArray()
            
            for i in 0..<posts.count
            {
                let post = posts[i]["post"]
                
                let itemId = post["id"].intValue
                let itemIdUser = post["iduser"].stringValue
                let itemName = post["itemname"].stringValue
                let itemDescription = post["itemdescription"].stringValue
                let itemLongitude = post["itemlongitude"].stringValue
                let itemLatitude = post["itemlatitude"].stringValue
                let itemAdress = post["itemadress"].stringValue
                let itemReward = post["itemreward"].stringValue
                
                let images = post["images"].arrayValue
                var imageArray = NSMutableArray()
                for i in 0..<images.count
                {
                    let image = images[i].stringValue
                    imageArray.add(image)
                }
                
                print("имя весчи \(itemName)")
                
                let item = Item(id: "\(itemId)", title: itemName, description: itemDescription, photosURL: imageArray, longitude: itemLongitude, latitude: itemLatitude, userId: itemIdUser)
                outData.add(item)
            }
            
            if self.isCancelled == false
            {
                self.success(outData)
            }
            else
            {
                self.success(NSArray())
            }
            
            semaphore.signal()
            
        }, failure: { (code) in
            semaphore.signal()
            self.failure(code)
        })
        
        
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
    }
    
}
