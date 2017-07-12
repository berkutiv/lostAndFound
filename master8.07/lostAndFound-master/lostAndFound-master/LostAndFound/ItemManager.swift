//
//  ItemManager.swift
//  LostAndFound
//
//  Created by Орлов Максим on 05.07.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import Foundation

class ItemManager
{
    class func getItems (itemID : String, success : @escaping (NSArray) -> Void, failure : (Int) -> Void)
    {
        let itemOperation = ItemOperation(itemID: itemID, success: {(itemData) in
            
            success(itemData)
            
        }, failure: {(error) in
        
            print ("Ошибка в операции - \(error)")
        })
        
        OperationsManager.addOperation(op: itemOperation, cancellingQueue: true)
    }
}
