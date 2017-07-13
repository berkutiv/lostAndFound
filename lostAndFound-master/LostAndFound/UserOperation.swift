//
//  UserOperation.swift
//  LostAndFound
//
//  Created by Иван on 26.04.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import Foundation

class UserOperation: Operation
{
    var success: (User) -> Void
    var failure: (Int) -> Void
    var id: String
    
    var internetTask : URLSessionDataTask?
    
    init(id: String, success: @escaping (User) -> Void, failure: @escaping (Int) -> Void)
    {
        self.id = id
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
        internetTask = API_WRAPPER.getUser(userId: id, success: { (jsonResponce) in
            
            let user = jsonResponce["response"]["user"]
            print("json \(jsonResponce)")
            
            let userName = user["displayName"].stringValue
            let userMail = user["email"].stringValue
            let userId = user["uid"].stringValue
            
            let mainUser = User(id: userId)
            let userHeader = UserHeader(id: userId, name: userName, phone: "", email: userMail, photo: "")
            mainUser.modelsArray.add(userHeader)
            
            API_WRAPPER.getUserItems(user: mainUser, userId: mainUser.id, success: { (jsonResponce) in
                
                let itemsArray = NSMutableArray()
                
                let posts = jsonResponce["posts"].arrayValue
                
                for i in 0..<posts.count
                {
                    let post = posts[i]
                    let postName = post["itemname"].stringValue
                    let postDescription = post["itemdescription"].stringValue
                    let postAddress = post["itemadress"].stringValue
                    let postId = post["id"].stringValue
                    let longitude = post["itemlongitude"].stringValue
                    let latitide = post["itemlatitude"].stringValue
                    
                    let images = post["images"].arrayValue
                    var imageArray = NSMutableArray()
                    for i in 0..<images.count
                    {
                        let image = images[i].stringValue
                        imageArray.add(image)
                    }
                    
                    let postModel = Item(id: postId, title: postName, description: postDescription, photosURL: imageArray, longitude: longitude, latitude: latitide, userId: mainUser.id)
                    
                    let model = UserItem(item: postModel)
                    
                    
                    mainUser.modelsArray.add(model)
                    itemsArray.add(postModel)
                    
                }
                
                
                print("main user array \(mainUser.modelsArray)")
                
                if self.isCancelled == false
                {
                    self.success(mainUser)
                }
                else
                {
                    self.success(User(id: ""))
                }
                semaphore.signal()
                
            }, failure: { (code) in
                
            })
            
            
            
            
        }, failure: { (code) in
            semaphore.signal()
            self.failure(code)
        })
        
        
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
    }
    
}
