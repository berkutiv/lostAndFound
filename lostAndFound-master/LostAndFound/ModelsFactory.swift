//
//  ModelsFactory.swift
//  LostAndFound
//
//  Created by Иван on 25.04.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import Foundation

class ModelsFactory
{
    private static var dataSource = NSMutableArray()
    
    private static let names = ["перчатки", "телефон", "кошелек", "ключи", "кот", "собака", "книга", "часы", "ноутбук", "автомобиль", "чашка чаю", "стул", "страх", "чевото", "штука"]
    
    
    class func generateModels() -> NSArray
    {
        for i in 0...20
        {
            var randomInt = Int(arc4random_uniform(13))
            var randomLat = Int(arc4random_uniform(60))
            var randomLon = Int(arc4random_uniform(60))
            let model = Item(id: "\(i)", title: names[randomInt], description: "", photosURL: [], longitude: "\(randomLon)", latitude: "\(randomLat)", userId: "")
            dataSource.add(model)
        }
        return dataSource
    }
    
    class func getModelsForUser() -> NSArray
    {
        var data = NSMutableArray()
        var randCount = Int(arc4random_uniform(7))
        for i in 0...randCount
        {
            var randomInt = Int(arc4random_uniform(13))
            var randomLat = Int(arc4random_uniform(60))
            var randomLon = Int(arc4random_uniform(60))
            let model = Item(id: "\(i)", title: names[randomInt], description: "", photosURL: [], longitude: "\(randomLon)", latitude: "\(randomLat)", userId: "")
            data.add(model)
        }
        return data
    }
}
