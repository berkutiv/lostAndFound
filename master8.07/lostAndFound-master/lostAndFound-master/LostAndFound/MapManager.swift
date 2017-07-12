//
//  MapManager.swift
//  LostAndFound
//
//  Created by Иван on 26.04.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import Foundation

class MapManager
{
    class func getItems(success : @escaping (NSArray) -> Void , failure : @escaping (Int) -> Void)
    {
        let mapOperation = MapOperation(success: { (array) in
            success(array)
        }) { (code) in
            print("Ошибка в операции \(code)")
        }
        
        OperationsManager.addOperation(op: mapOperation, cancellingQueue: true)
    }
}
