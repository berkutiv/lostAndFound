//
//  ItemPhotoCollectionModel.swift
//  LostAndFound
//
//  Created by Орлов Максим on 16.05.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import UIKit

class ItemPhotoCollectionModel
{
    var photosUrls : NSArray
    var itemName : String
    
    init(photosUrls : NSArray, itemName : String)
    {
        self.photosUrls = photosUrls
        self.itemName = itemName
    }
    
    
//    var photosUrls : NSArray = [UIImage (named: "Document")!, UIImage (named: "Document1")!]
//    var itemName = "Документы"
}
