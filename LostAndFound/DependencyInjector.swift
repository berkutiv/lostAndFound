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
        
        if view is MapViewController
        {
            //presenter = FriendsPresenter()
        }
        
        
        if presenter != nil
        {
            view.assignPresenter(presenter: presenter!)
        }
    }
}
