//
//  Item.swift
//  LostAndFound
//
//  Created by Иван on 12.04.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import Foundation

class Item
{
    var id: String
    var title: String
    var description: String
    var photosURL = NSMutableArray()
    var longitude: String
    var latitude: String
    var userName: String?
    var userId: String
    var userPhone: String?
    var userEmail: String?
    
    init(id: String, title: String, description: String, photosURL: NSMutableArray, longitude: String, latitude: String, userId: String)
    {
        self.id = id
        self.title = title
        self.description = description
        self.photosURL = photosURL
        self.longitude = longitude
        self.latitude = latitude
        self.userId = userId
    }
    
}
