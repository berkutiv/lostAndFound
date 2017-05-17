//
//  ItemPresenter.swift
//  LostAndFound
//
//  Created by Орлов Максим on 16.05.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import Foundation

class ItemPresenter
{
    weak var view : View?
    var dataSource = NSMutableArray()
    var itemId = ""
    
}

extension ItemPresenter : Presenter
{
    /**
     функция, вызываемая, когда загрузился вью
     */
    func viewLoaded(view: View) -> Void
    {
        let itemPhotos = ItemPhotoCollectionModel()
        dataSource.add(itemPhotos)
        let itemDescription = ItemDescriptionModel()
        dataSource.add(itemDescription)
        
        
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
        if let itemID = data["item_id"] as? String
        {
            self.itemId = itemID
        }
    }

}
