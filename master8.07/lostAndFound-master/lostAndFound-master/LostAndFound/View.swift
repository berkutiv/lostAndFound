//
//  View.swift
//  LostAndFound
//
//  Created by Иван on 22.04.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import Foundation

protocol View: class
{
    /**
     назначение презентера
     */
    func assignPresenter(presenter: Presenter) -> Void
    
    /**
     перезагрузка экрана
     */
    func reloadData() -> Void
    
    /**
     включение loader'a
     */
    func addLoader() -> Void
    
    /**
     выключение loader'a
     */
    func removeLoader() -> Void
    
    /**
     коды ошибок интернета
     */
    func handleInternetErrorCode(code: Int) -> Void
}
