//
//  SetLocationOperation.swift
//  LostAndFound
//
//  Created by Орлов Максим on 19.05.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import Foundation
import GoogleMaps

class SetLocationOperation : Operation
{
    var success : (String) -> Void
    var failure : (Int) -> Void
    var longitude : CLLocationDegrees
    var latitude : CLLocationDegrees
    
    var internetTask : URLSessionDataTask?
    
    init (latitude : CLLocationDegrees, longitude : CLLocationDegrees, success : @escaping (String) -> Void, failure : @escaping (Int) -> Void)
    {
        self.longitude = longitude
        self.latitude = latitude
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
        
        internetTask = API_GEOCODER.getAdress(latitude: latitude, longitude: longitude, success: { (jsonResponse) in
            
            let data = jsonResponse["results"].arrayValue
            
            let item = data[0]
            let adress = item["formatted_address"].stringValue
            print("Адрес - \(adress)")
            
            if self.isCancelled == false
            {
                self.success(adress)
            }
                
            else
            {
                self.success("")
            }
            
            semaphore.signal()
            
        }, failure: {errorCode in
            
            semaphore.signal()
            self.failure(errorCode)
        })
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
    }
    
}
