//
//  MapPresenter.swift
//  LostAndFound
//
//  Created by Иван on 26.04.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import Foundation

class MapPresenter: Presenter
{
    var dataSource = NSMutableArray()
    weak var view: View?
    
    func viewLoaded(view: View) -> Void
    {
        self.view = view
        getData(substring: "")
    }
    
    func numberOfModels(inSection section: Int) -> Int
    {
        return dataSource.count
    }
    
    func numberOfSections() -> Int
    {
        return 1
    }
    
    func getModel(by id: String) -> Any
    {
        for i in 0..<dataSource.count
        {
            if (dataSource[i] as! Item).id == id
            {
                return dataSource[i]
            }
        }
        return 0
    }
    
    private func getData(substring: String)
    {
        MapManager.getItems(success: { [weak self](items) in
            DispatchQueue.main.async{
                print("count презентер\(items.count)")
                self?.view?.removeLoader()
                self?.dataSource = NSMutableArray(array: items)
                self?.view?.reloadData()
            }
        }) { [weak self](code) in
            DispatchQueue.main.async{
                self?.view?.removeLoader()
                self?.view?.handleInternetErrorCode(code: code)
            }
        }
    }
    
    func model (at indexPath : IndexPath) ->Any
    {
        let model = dataSource[indexPath.row]
        return model
    }
    
    func provide (data : NSDictionary)
    {
        
    }
    
    func viewLoadedWithID(id: String, view: View)
    {
       
    }
}
