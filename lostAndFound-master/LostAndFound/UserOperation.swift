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
            
            let userName = user["displayName"].stringValue
            let userMail = user["email"].stringValue
            let userId = user["uid"].stringValue
            
            let mainUser = User(id: userId)
            let userHeader = UserHeader(id: userId, name: userName, phone: "", email: userMail, photo: "")
            mainUser.modelsArray.add(UserHeader)
            //print("user name \(userName)")
            
            API_WRAPPER.getUserItems(user: mainUser, userId: self.id, success: { (jsonResponce) in
            
                print("json \(jsonResponce)")
                
                if self.isCancelled == false
                {
                     self.success(mainUser)
                }
                else
                {
                    self.success(User(id: ""))
                }
                
            }, failure: { (code) in
                
            })
            
            
            semaphore.signal()
            
        }, failure: { (code) in
            semaphore.signal()
            self.failure(code)
        })
        
        
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
    }

}
