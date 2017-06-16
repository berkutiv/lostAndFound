//
//  LoginManager.swift
//  LostAndFound
//
//  Created by Орлов Максим on 09.06.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import Foundation

class LoginManager
{
static var status = ""
static var token = ""
static var userId = ""

class func authUserWithEmail(email: String, password : String, success : @escaping (String, String, String) -> Void , failure : @escaping (Int) -> Void)
{
    let addOperation = LoginOperation(email: email, password: password, success: { (response) in
    
        print("СРАБОТАЛ ЛОГИН МЕНЕДЖЕР")
        
        status = response.0
        token = response.1
        userId = response.2
        
        print(status)
        
        success(status, token, userId)
        
    } , failure: failure )

    OperationsManager.addOperation(op: addOperation, cancellingQueue: true)
    
    }
}
