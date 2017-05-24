//
//  UserManager.swift
//  LostAndFound
//
//  Created by Иван on 26.04.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import Foundation

class UserManager
{
    class func getUser(id: String, success : @escaping (NSArray) -> Void , failure : @escaping (Int) -> Void)
    {
        let userOperation = UserOperation(id: id, success: { (array) in
            success(array)
        }, failure: failure)
        OperationsManager.addOperation(op: userOperation, cancellingQueue: true)
    }
}
