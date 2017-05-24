//
//  UserHeaderTableViewCell.swift
//  LostAndFound
//
//  Created by Иван on 03.05.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import UIKit

class UserHeaderTableViewCell: UITableViewCell
{
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userAvatar: UIImageView!
    
    func configureSelf(withDataModel model: User)
    {
        userNameLabel.text = model.name
        userAvatar.image = UIImage(named: model.photo)
    } 
}
