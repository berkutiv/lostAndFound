//
//  OperationsManager.swift
//  LostAndFound
//
//  Created by Иван on 12.05.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import Foundation

class OperationsManager
{
    private static let businessOparationQueue = OperationQueue()
    
    class func addOperation(op: Operation, cancellingQueue: Bool)
    {
        businessOparationQueue.maxConcurrentOperationCount = 1
        
        if cancellingQueue
        {
            businessOparationQueue.cancelAllOperations()
        }
        
        businessOparationQueue.addOperation(op)
    }
}
