//
//  UsersFactory.swift
//  LostAndFound
//
//  Created by Иван on 03.05.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import Foundation

class UsersFactory
{
    private static let kProfessions = ["Адвокат" , "Генеральный секретарь", "Делопроизводитель" , "Детектив" , "Дипломат" , "Конвоир" , "Милиционер" , "Министр" , "Нотариус" , "Охранник" , "Полицейский" , "Венеролог" , "Вирусолог" , "Гинеколог" , "Теолог" , "Сурдопедагог" , "Зелёный человечек" , "Стукач", "Вышивальщица" , "Поп"]
    
    private static let kNames = ["Филипп", "Лукас", "Евгений", "Елена", "Мартин", "Снежана", "Анжела", "Маргарита", "Тарзан", "Марк", "Эмма", "Изабелла", "Алонсо", "Арни", "Кристиан", "Лев", "Аля", "Надин", "Марта", "Севастьян" ]
    
    private static var outArray = NSMutableArray()
    
    class func generateData() -> NSArray
    {
        let randIndex = Int(arc4random_uniform(19))
        
        for i in 0..<20
        {
            let randIndex = Int(arc4random_uniform(19))
            let prof = kProfessions[randIndex]
            let name = kNames[randIndex]
            
            let user = User(id: "\(i)", name: name, phone: "", email: "", photo: "\(randIndex)")
            user.itemsCollection = ModelsFactory.getModelsForUser() as! NSMutableArray
            outArray.add(user)
        }
        return outArray
    }
    
    class func getUser(id: String) -> User
    {
        for i in 0..<outArray.count
        {
            if (outArray[i] as! User).id == id
            {
                return outArray[i] as! User
            }
        }
        
        return User(id: "", name: "пустой юзер", phone: "", email: "", photo: "")
    }
}
