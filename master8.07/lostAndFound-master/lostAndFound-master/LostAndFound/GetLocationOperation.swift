//
//  GetLocationOperation.swift
//  LostAndFound
//
//  Created by Орлов Максим on 16.06.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import Foundation
import GoogleMaps
import GooglePlaces

class GetLocationOperation : Operation
{
    var success : (CLLocationDegrees, CLLocationDegrees) -> Void
    var failure : (Int) -> Void
    var adress : GMSPlace
    
    var internetTask : URLSessionDataTask?
    
    init (adress : GMSPlace, success : @escaping (CLLocationDegrees, CLLocationDegrees) -> Void, failure : @escaping (Int) -> Void)
    {
        self.adress = adress
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
        
        internetTask = API_GEOCODER.getLocation(adress: adress, success: { (jsonResponse) in
            
            let data = jsonResponse["results"].arrayValue
            
            let item = data[0]
            let latitudeString = item["geometry"]["location"]["lat"].stringValue
            let longitudeString = item["geometry"]["location"]["lng"].stringValue
            
            print(latitudeString)
            print(longitudeString)
            
            let latitude : CLLocationDegrees = Double(latitudeString)!
            let longitude : CLLocationDegrees = Double(longitudeString)!
            
            if self.isCancelled == false
            {
                self.success(latitude, longitude)
            }
                
            else
            {
                self.success(55.751244,37.618423)
            }
            
            semaphore.signal()
            
            }, failure: { (errorCode) in
                
             semaphore.signal()
                self.failure(errorCode)
            })
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
    }
    
}
