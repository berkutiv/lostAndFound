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
    var success: (NSArray) -> Void
    var failure: (Int) -> Void
    var id: String
    
    var internetTask : URLSessionDataTask?
    
    init(id: String, success: @escaping (NSArray) -> Void, failure: @escaping (Int) -> Void)
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
        internetTask = API_WRAPPER.getUsers(id: id, success: { (array) in
            
            if self.isCancelled == false
            {
                self.success(array)
            }
            else
            {
                self.success([])
            }
            
            semaphore.signal()
            
        }, failure: { (code) in
            semaphore.signal()
            self.failure(code)
        })
        
        
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
    }

}
