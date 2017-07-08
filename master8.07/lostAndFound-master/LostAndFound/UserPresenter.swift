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
    var user = User(id: "презентер")
    weak var view: View?
    var userId = ""
    
    func viewLoaded(view: View) -> Void
    {
        self.view = view
        view.addLoader()
        getData(id: userId)
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
        return user
    }
    
    private func getData(id: String)
    {
        UserManager.getUser(id: id, success: { (user) in
            DispatchQueue.main.async{
                self.view?.removeLoader()
                self.user = user
                print("user name \(self.user.id)")
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
        if let userId = data["user_id"] as? String
        {
            self.userId = userId
        }
    }
    
    func model (at indexPath : IndexPath) ->Any
    {
        return self
    }
    
    func viewLoadedWithID(id: String, view: View) {
        
    }
    
    
}
