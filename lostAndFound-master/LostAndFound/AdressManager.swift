//
//  AdressManager.swift
//  LostAndFound
//
//  Created by Орлов Максим on 05.05.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import Foundation
import GoogleMaps
class AdressManager
{
    class func getAdress ( latitude : CLLocationDegrees ,  longitude  : CLLocationDegrees , success : @escaping (String) -> Void , failure : @escaping (Int) -> Void)
    {
        API_GeoCoder.getAdress(latitude: latitude, longitude: longitude, success: { (jsonResponse) in
            
            let data = jsonResponse["results"]
            let adress = data["formatted_address"].stringValue
            print("Адрес - \(adress)")
            
            success(adress)
            
            
        }, failure:
            {errorCode in
                failure(errorCode)
        })
    }
}
