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
}

extension ItemPresenter : Presenter
{
    /**
     функция, вызываемая, когда загрузился вью
     */
    func viewLoaded(view: View) -> Void
    {
//        let itemPhotos = ItemPhotoCollectionModel()
//        dataSource.add(itemPhotos)
//        let itemHeader = ItemHeaderModel()
//        dataSource.add(itemHeader)
//        let itemMapCoordinates = ItemMapModel()
//        dataSource.add(itemMapCoordinates)
//        let itemDescription = ItemDescriptionModel()
//        dataSource.add(itemDescription)
//        let itemContacts = ItemContactsModel()
//        dataSource.add(itemContacts)
        
       
    }
    
    func viewLoadedWithID(id: String, view: View)
    {
        self.view = view
        getData(id: id)
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
    
    private func getData (id : String)
    {
        ItemManager.getItems(itemID: id, success: { [weak self](item) in
            
            DispatchQueue.main.async
                {
                    print("ПРИШЛО ЧЕ ТА - \(item.count)")
                    self?.view?.removeLoader()
                    self?.dataSource = item as! NSMutableArray
                    self?.view?.reloadData()
                }
            
            }, failure: { [weak self] (error) in
                
            DispatchQueue.main.async
                {
                    self?.view?.removeLoader()
                    self?.view?.handleInternetErrorCode(code: error)
                    print(error)
                }
        })
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
//        if let itemID = data["item_id"] as? String
//        {
//            self.itemId = itemID
//        }
    }
}
