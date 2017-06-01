//
//  ItemContactsTableViewCell.swift
//  LostAndFound
//
//  Created by Орлов Максим on 18.05.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import UIKit

class ItemContactsTableViewCell: UITableViewCell
{
    @IBOutlet weak var itemUserName: UILabel!
    @IBOutlet weak var itemUserPhoto: UIImageView!
    @IBOutlet weak var itemUserContactNumber: UILabel!
    @IBOutlet weak var itemUserEmail: UILabel!
    
    func configureSelf (withDataModel model : ItemContactsModel)
    {
        itemUserName.text = model.itemUserName
        itemUserPhoto.image = model.itemUserPhoto
        itemUserContactNumber.text = model.itemUserContactNumber
        itemUserEmail.text = model.itemUserEmail
        
        itemUserPhoto.layer.cornerRadius = self.itemUserPhoto.frame.width/6.4
        itemUserPhoto.layer.masksToBounds = true
    }
}
