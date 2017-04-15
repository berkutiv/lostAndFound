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
    var coordinates: String
    var userName: String?
    var userId: String
    var userPhone: String?
    var userEmail: String?
    
    init(id: String, title: String, description: String, photosURL: NSMutableArray, coordinates: String, userId: String)
    {
        self.id = id
        self.title = title
        self.description = description
        self.photosURL = photosURL
        self.coordinates = coordinates
        self.userId = userId
        
        print("fuck you too")
    }
    
}
