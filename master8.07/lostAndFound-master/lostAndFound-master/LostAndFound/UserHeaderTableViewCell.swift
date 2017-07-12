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
    var editBlock: ((UserHeader) -> Void)!
    var model = UserHeader(id: "", name: "", phone: "", email: "", photo: "")
    
    func configureSelf(withDataModel model: UserHeader)
    {
        self.model = model
        userNameLabel.text = model.name
        print("ячейка имя \(model.name)")
        userAvatar.image = UIImage(named: "1")
        userAvatar.layer.cornerRadius = self.userAvatar.frame.width/2
        userAvatar.layer.masksToBounds = true
    }
    
    @IBAction func edit(_ sender: Any)
    {
        print("нажали")
        editBlock(model)
    }
}
