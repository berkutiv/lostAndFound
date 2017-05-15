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
    var user = User(id: "", name: "", phone: "", email: "", photo: "")
    weak var view: View?
    
    func viewLoaded(view: View) -> Void
    {
        self.view = view
        view.addLoader()
        getData(id: "1")
    }
    
    func numberOfModels(inSection section: Int) -> Int
    {
        return 1
    }
    
    func numberOfSections() -> Int
    {
        return 1
    }
    
    func getModel(atIndexPath indexPath: IndexPath) -> Any
    {
        return user
    }
    
    private func getData(id: String)
    {
        UserManager.getUser(id: id, success: { (user) in
            DispatchQueue.main.async{
                self.view?.removeLoader()
                self.user = user
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
}
