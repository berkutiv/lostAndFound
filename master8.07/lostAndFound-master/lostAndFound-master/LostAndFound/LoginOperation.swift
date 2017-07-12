//
//  LoginOperation.swift
//  LostAndFound
//
//  Created by Орлов Максим on 09.06.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import Foundation

class LoginOperation : Operation
{
    var success : (String, String, String) -> Void
    var failure : (Int) -> Void
    var email : String
    var password : String
    
    var internetTask : URLSessionDataTask?
    
    init (email : String, password : String, success : @escaping (String,String,String) -> Void, failure : @escaping (Int) -> Void)
    {
        self.email = email
        self.password = password
        self.success = success
        self.failure = failure
    }
    
    override func cancel()
    {
        internetTask?.cancel()
    }
    
    override func main()
    {
        let semaphore = DispatchSemaphore(value : 0)
        
        internetTask = API_WRAPPER.AuthUserWithEmail(email: email, password: password, success: { (jsonResponse) in
       
            let data = jsonResponse["response"]
            
            let userSuccess = data["success"].stringValue
            let userId = data["user"]["uid"].stringValue
            let userToken = data["user"]["stsTokenManager"]["accessToken"].stringValue
            
            //print("Пользователь вошел - \(userSuccess)")
            print("ID пользователя - \(userId)")
            //print("Token пользователя - \(userToken)")
            
            if self.isCancelled == false
            {
                self.success(userSuccess, userToken, userId)
            }
                
            else
            {
                self.success("", "", "")
            }
            
            semaphore.signal()
        }
            
            , failure: {errorCode in
                semaphore.signal()
                self.failure(errorCode)
            })
        
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
    }
    
}
