//
//  RegisterManager.swift
//  LostAndFound
//
//  Created by Орлов Максим on 12.06.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import Foundation

class RegisterManager
{
    static var alert = ""
    
    class func createUserWithEmail(email: String, userName : String,  password : String, passwordRepeat : String, success : @escaping (String) -> Void , failure : @escaping (Int) -> Void)
    {
        let addOperation = RegisterOperation(email: email, userName: userName, password: password, passwordRepeat: passwordRepeat, success: {(response) in
            
            alert = response
            
            success(alert)

        }, failure: failure )
        
        OperationsManager.addOperation(op: addOperation, cancellingQueue: true)
    }
}
