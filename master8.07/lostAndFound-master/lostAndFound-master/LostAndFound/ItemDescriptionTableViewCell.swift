//
//  ItemDescriptionTableViewCell.swift
//  LostAndFound
//
//  Created by Орлов Максим on 11.05.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import UIKit

class ItemDescriptionTableViewCell: UITableViewCell
{
    @IBOutlet weak var itemDescription: UILabel!
    
    func configureSelf (withDataModel model : ItemDescriptionModel)
    {
        itemDescription.text = model.itemDescription
        itemDescription.lineBreakMode = NSLineBreakMode.byWordWrapping
        itemDescription.numberOfLines = 0
        
    }
}
