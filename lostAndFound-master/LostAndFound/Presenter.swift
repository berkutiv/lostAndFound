//
//  Presenter.swift
//  LostAndFound
//
//  Created by Иван on 22.04.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import Foundation

protocol Presenter: class
{
    /**
     функция, вызываемая, когда загрузился вью
     */
    func viewLoaded(view: View) -> Void
    
    /**
     количество моделей на экране
     */
    func numberOfModels(inSection section: Int) -> Int
    
    /**
     количество секций
     */
    func numberOfSections() -> Int
    
    /**
     получение моделей
     */
    func getModel(atIndexPath indexPath: IndexPath) -> Any
    
    /**
     дополнительные данные
     */
    func provide (data : NSDictionary)
    
}
