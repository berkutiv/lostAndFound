//
//  ItemMapModel.swift
//  LostAndFound
//
//  Created by Орлов Максим on 18.05.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import Foundation
import GoogleMaps

class ItemMapModel
{
    var latitude : CLLocationDegrees
    var longitude : CLLocationDegrees
    var itemAdress : String
    
    init (latitude : CLLocationDegrees, longitude : CLLocationDegrees, itemAdress : String)
    {
        self.itemAdress = itemAdress
        self.latitude = latitude
        self.longitude = longitude
    }
}
