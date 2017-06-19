//
//  GetLocationManager.swift
//  LostAndFound
//
//  Created by Орлов Максим on 16.06.17.
//  Copyright © 2017 Иван. All rights reserved.
//
import Foundation
import GoogleMaps
import GooglePlaces

class GetLocationManager
{
    static var internetStarted = false
    static var latitude = CLLocationDegrees()
    static var longitude = CLLocationDegrees()
    
    class func getLocation (adress : GMSPlace, success : @escaping (CLLocationDegrees, CLLocationDegrees) -> Void, failure : @escaping (Int) -> Void)
    {
        let addOperation = GetLocationOperation(adress: adress, success: { (location) in
            
            latitude = location.0
            longitude = location.1
            
            success(latitude, longitude)
            
        } , failure: failure)
            
            OperationsManager.addOperation(op: addOperation, cancellingQueue: true)
    }
}
