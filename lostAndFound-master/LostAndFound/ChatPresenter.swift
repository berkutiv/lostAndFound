//
//  ChatPresenter.swift
//  LostAndFound
//
//  Created by Иван on 26.04.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import Foundation

class ChatPresenter : Presenter
{
    
    weak var view : View?
    var dataSource = NSMutableArray()
    var userID = ""
}

extension ChatPresenter
{
    /**
     функция, вызываемая, когда загрузился вью
     */
    func viewLoaded(view: View) -> Void
    {
        dataSource = ChatModel.configureDataSource() 
        view.reloadData()
    }
    
    /**
     количество моделей на экране
     */
    func numberOfModels(inSection section: Int) -> Int
    {
        return dataSource.count
    }
    
    /**
     количество секций
     */
    func numberOfSections() -> Int
    {
        return 1
    }
    
    /**
     получение моделей
     */
    func getModel(by id: String) -> Any
    {
        return self
    }
    /**
     
     */
    func model (at indexPath : IndexPath) ->Any
    {
        return dataSource[indexPath.row]
    }
    
    /**
     дополнительные данные
     */
    func provide (data : NSDictionary)
    {
        if let userID = data["user_id"] as? String
        {
            self.userID = userID
        }
        
    }
    
    func viewLoadedWithID(id: String, view: View) {
        
    }
}
