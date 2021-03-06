//
//  UserButtonsTableViewCell.swift
//  LostAndFound
//
//  Created by Иван on 03.05.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import UIKit

class UserButtonsTableViewCell: UITableViewCell
{
    @IBOutlet weak var messageButton: UIButton!

    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    func configureSelf(withDataModel model: UserButtons)
    {
        messageButton.layer.cornerRadius = self.messageButton.frame.width/22.0
        messageButton.layer.masksToBounds = true
    }

    @IBAction func sendMessage(_ sender: Any)
    {
        
    }
}
