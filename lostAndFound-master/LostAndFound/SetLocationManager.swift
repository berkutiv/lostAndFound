//
//  AdressManager.swift
//  LostAndFound
//
//  Created by Орлов Максим on 05.05.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import Foundation
import GoogleMaps
class SetLocationManager
{
    static var adress = String("")
    static var internetStarted = false
    
    class func getAdress ( latitude : CLLocationDegrees ,  longitude  : CLLocationDegrees , success : @escaping (String) -> Void , failure : @escaping (Int) -> Void)
    {
        let addOperation = SetLocationOperation (latitude: latitude, longitude: longitude, success: { (currentAdress) in
            
            print(currentAdress)
            adress = currentAdress
            
            success(adress!)
            
        }, failure: failure)
        
        OperationsManager.addOperation(op: addOperation, cancellingQueue: true)
    }
}
