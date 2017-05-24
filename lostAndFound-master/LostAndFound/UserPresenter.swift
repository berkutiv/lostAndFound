//
//  UserPresenter.swift
//  LostAndFound
//
//  Created by Иван on 26.04.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import Foundation

class UserPresenter: Presenter
{
    var dataSource = NSMutableArray()
    weak var view: View?
    
    func viewLoaded(view: View) -> Void
    {
        self.view = view
        view.addLoader()
        getData(id: "")
    }
    
    func numberOfModels(inSection section: Int) -> Int
    {
        return 1
    }
    
    func numberOfSections() -> Int
    {
        return 1
    }
    
    func getModel(by id: String) -> Any
    {
        for i in 0..<dataSource.count
        {
            if ((dataSource[i] as! User).id == id)
            {
                return dataSource[i] as! User
            }
        }
        return 0
    }
    
    private func getData(id: String)
    {
        
        //ДОЛГО ДОХОДЯТ ДАННЫЕ, НЕОБХОДИМ СИГНАЛЬНЫЙ БЛОК, ИЛИ ЧТО-ТО ВРОДЕ ЭТОГО
        
        UserManager.getUser(id: id, success: { (array) in
            DispatchQueue.main.async{
                self.view?.removeLoader()
                self.dataSource = array as! NSMutableArray
                print("count \(self.dataSource.count)")
                self.view?.reloadData()
            }
        }) { [weak self](code) in
            DispatchQueue.main.async{
                self?.view?.removeLoader()
                self?.view?.handleInternetErrorCode(code: code)
            }
        }
    }
    
    func provide(data: NSDictionary)
    {
    
    }
    
    func model (at indexPath : IndexPath) ->Any
    {
        return self
    }
    
    
}
