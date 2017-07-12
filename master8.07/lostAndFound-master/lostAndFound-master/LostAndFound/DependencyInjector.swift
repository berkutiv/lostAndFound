//
//  DependencyInjector.swift
//  LostAndFound
//
//  Created by Иван on 22.04.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import Foundation

class DependencyInjector
{
    class func obtainPresenter(view: View)
    {
        var presenter : Presenter?
        
        if view is UserPageViewController
        {
            presenter = UserPresenter()
        }
        
        if view is ItemViewController
        {
            presenter = ItemPresenter()
        }
        
        if view is ChatViewController
        {
            presenter = ChatPresenter()
        }
        
        if view is MapViewController
        {
            presenter = MapPresenter()
        }
        if presenter != nil
        {
            view.assignPresenter(presenter: presenter!)
        }
    }
}
