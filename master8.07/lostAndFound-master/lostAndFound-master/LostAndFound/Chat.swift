//
//  Chat.swift
//  LostAndFound
//
//  Created by Орлов Максим on 19.05.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import UIKit
class Chat
{
    var chatUserName : String
    var chatUserPhoto : UIImage
    var chatLastMessage : String
    
    init (chatUserName : String, chatUserPhoto : UIImage, chatLastMessage : String)
    {
        self.chatUserName = chatUserName
        self.chatUserPhoto = chatUserPhoto
        self.chatLastMessage = chatLastMessage
    }
}
