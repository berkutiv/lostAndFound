//
//  ItemContactsModel.swift
//  LostAndFound
//
//  Created by Орлов Максим on 18.05.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import  UIKit
class ItemContactsModel
{
    var itemUserId : String
    var itemUserName : String
    var itemUserPhoto : UIImage
    
    init(itemUserId : String, itemUserName : String, itemUserPhoto : UIImage)
    {
        self.itemUserId = itemUserId
        self.itemUserName = itemUserName
        self.itemUserPhoto = itemUserPhoto
    }
}
