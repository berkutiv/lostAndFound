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
    @IBOutlet weak var chatButton: UIButton!
    
    func configureSelf (withDataModel model : ItemContactsModel)
    {
        itemUserName.text = model.itemUserName
        itemUserPhoto.image = model.itemUserPhoto
        
        itemUserPhoto.layer.cornerRadius = self.itemUserPhoto.frame.width/2
        itemUserPhoto.layer.masksToBounds = true
        
        chatButton.layer.borderWidth = 1
        chatButton.layer.cornerRadius = self.chatButton.frame.width/18
        chatButton.layer.masksToBounds = true
    }
}
