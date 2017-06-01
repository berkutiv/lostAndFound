//
//  ChatTableViewCell.swift
//  LostAndFound
//
//  Created by Орлов Максим on 19.05.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell
{
    @IBOutlet weak var chatLastMessage: UILabel!
    @IBOutlet weak var chatUserName: UILabel!
    @IBOutlet weak var chatImage: UIImageView!
    
    func configureSelf(withDataModel model : Chat)
    {
        chatLastMessage.text = model.chatLastMessage
        chatUserName.text = model.chatUserName
        chatImage.image = model.chatUserPhoto
        
        chatImage.layer.cornerRadius = self.chatImage.frame.width/6.4
        chatImage.layer.masksToBounds = true
    }
}
