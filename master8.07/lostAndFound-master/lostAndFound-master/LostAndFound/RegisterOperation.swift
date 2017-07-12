//
//  RegisterOperation.swift
//  LostAndFound
//
//  Created by Орлов Максим on 12.06.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import Foundation

class RegisterOperation : Operation
{
    var success : (String) -> Void
    var failure : (Int) -> Void
    var email : String
    var userName : String
    var password : String
    var passwordRepeat : String
    
    var internetTask : URLSessionDataTask?
    
    init (email : String, userName : String, password : String, passwordRepeat : String, success : @escaping (String) -> Void, failure : @escaping (Int) -> Void)
    {
        self.email = email
        self.userName = userName
        self.password = password
        self.success = success
        self.failure = failure
        self.passwordRepeat = passwordRepeat
    }
    
    override func cancel()
    {
        internetTask?.cancel()
    }
    
    override func main()
    {
        let semaphore = DispatchSemaphore(value : 0)
        
        internetTask = API_WRAPPER.createUserWithEmail(email: email, nameUser: userName, password: password, passwordRepeat: passwordRepeat, success: {(jsonResponse) in
            
            let data = jsonResponse["response"]
            
            let userSuccess = data["success"].stringValue
            var alert = ""
            
            if (userSuccess == "true")
            {
                alert = "noAlert"
                
                if self.isCancelled == false
                {
                    self.success(alert)
                }
                    
                else
                {
                    self.success("")
                }
            }
            
            else if (userSuccess == "false")
            {
                alert = data["errorMessage"].stringValue
                
                
                if self.isCancelled == false
                {
                    self.success(alert)
                }
                    
                else
                {
                    self.success("")
                }
            }
           
            print(alert)
            semaphore.signal()
        }
            
            , failure: {errorCode in
                semaphore.signal()
                self.failure(errorCode)
        })
        
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
    }
}
