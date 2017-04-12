//
//  User.swift
//  LostAndFound
//
//  Created by Иван on 12.04.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import Foundation

class User
{
    var id: String
    var name: String
    var phone: String
    var email: String
    var photo: String
    var itemsCollection = NSMutableArray()
    
    init(id: String, name: String, phone: String, email: String, photo: String)
    {
        self.id = id
        self.name = name
        self.phone = phone
        self.email = email
        self.photo = photo
    }
}
