//
//  ChatModels.swift
//  LostAndFound
//
//  Created by Орлов Максим on 19.05.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import UIKit

class ChatModel
{
    static var dataSource = NSMutableArray()
    
    static var chatUserName = ["Филипп", "Лукас", "Евгений", "Елена", "Мартин", "Снежана", "Анжела", "Маргарита", "Тарзан", "Марк", "Эмма", "Изабелла", "Алонсо", "Арни", "Кристиан", "Лев", "Аля", "Надин", "Марта", "Севастьян" ]
    static var chatLastMessage = ["КЛЮЧИ ВЕРНИ!", "CКА БЛЯ", "а ты ничего", "не могу найти закладку", ":)))", "скинь фотку", "Ясно", "Увы но нет", "Слава Украине!"]
    static var chatUserPhoto = [UIImage (named: "0")!, UIImage (named: "1")!, UIImage (named: "2")!, UIImage (named: "3")!, UIImage (named: "4")!, UIImage (named: "5")!, UIImage (named: "6")!, UIImage (named: "7")!, UIImage (named: "8")!, UIImage (named: "9")!, UIImage (named: "10")!, UIImage (named: "11")!]
    
    class func configureDataSource () -> NSMutableArray
    {
        
      
        
        for i in 1..<20
        {
        
            
            let model = Chat(chatUserName: chatUserName[Int(arc4random_uniform(UInt32(chatUserName.count)))], chatUserPhoto: chatUserPhoto[Int(arc4random_uniform(UInt32(chatUserPhoto.count)))], chatLastMessage: chatLastMessage[Int(arc4random_uniform(UInt32(chatLastMessage.count)))])
            dataSource.add(model)
        }
        
        return dataSource
    }
}
