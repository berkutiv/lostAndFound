//
//  AddManager.swift
//  LostAndFound
//
//  Created by Иван on 26.04.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import Foundation

class AddManager
{
    static var addSuccess = ""
    
    class func addItem (token : String, userId : String, itemName : String, itemDescription : String, itemLatitude : String, itemLongitude : String, itemReward : String, success : @escaping (String) -> Void, failure : @escaping (Int) -> Void)
    {
        let addOperation = AddOperation(token: token, userId: userId, itemName: itemName, itemDescription: itemDescription, itemLatitude: itemLatitude, itemLongitude: itemLongitude, itemReward: itemReward, success: {(response) in
            
            addSuccess = response
            success(addSuccess)
            
        }, failure: failure)
        
        OperationsManager.addOperation(op: addOperation, cancellingQueue: true)
    }    
}
