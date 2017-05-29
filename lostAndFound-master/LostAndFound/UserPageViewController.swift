//
//  UserPageViewController.swift
//  LostAndFound
//
//  Created by Иван on 14.04.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import UIKit

class UserPageViewController: UIViewController
{
    
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    let kUserHeaderNIB = UINib(nibName: "UserHeaderTableViewCell", bundle: nil)
    let kUserHeaderReuseIdentifier = "kUserHeaderReuseIdentifier"
    
    let kUserTableNIB = UINib(nibName: "UserTableTableViewCell", bundle: nil)
    let kUserTableReuseIdentifier = "kUserTableReuseIdentifier"
    
    let kUserButtonsNIB = UINib(nibName: "UserButtonsTableViewCell", bundle: nil)
    let kUserButtonsReuseIdentifier = "kUserButtonsReuseIdentifier"
    
    var presenter: Presenter?    
    var id = "1"
    var blockWithCoordinates: ((String, String) -> Void)!
    
    override func viewWillAppear(_ animated: Bool)
    {
        if presenter == nil
        {
            DependencyInjector.obtainPresenter(view: self)
        }
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 40.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedSectionHeaderHeight = 50
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        tableView.register(kUserHeaderNIB, forCellReuseIdentifier: kUserHeaderReuseIdentifier)
        tableView.register(kUserTableNIB, forCellReuseIdentifier: kUserTableReuseIdentifier)
        tableView.register(kUserButtonsNIB, forCellReuseIdentifier: kUserButtonsReuseIdentifier)
    }
}

extension UserPageViewController: View
{
    func assignPresenter(presenter: Presenter) -> Void
    {
        tableView.dataSource = self
        tableView.delegate = self
        self.presenter = presenter
        presenter.viewLoaded(view: self)
        
        tableView.reloadData()
    }
    
    func reloadData() -> Void
    {
        tableView.reloadData()
    }
    
    func addLoader() -> Void
    {
        
    }
    
    func removeLoader() -> Void
    {
        
    }
    
    func handleInternetErrorCode(code: Int) -> Void
    {
        let alertController = UIAlertController(title: "Ошибка", message: "Нет соединения", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension UserPageViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.row == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: kUserHeaderReuseIdentifier, for: indexPath) as! UserHeaderTableViewCell
            cell.configureSelf(withDataModel: presenter!.getModel(by: id) as! User)
            return cell
        }
        if indexPath.row == 1
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: kUserButtonsReuseIdentifier, for: indexPath) as! UserButtonsTableViewCell
            return cell
        }
        if indexPath.row == 2
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: kUserTableReuseIdentifier, for: indexPath) as! UserTableTableViewCell
            //print("count \(user.itemsCollection.count)")
            cell.configureSelf(withDataModel: presenter!.getModel(by: id) as! User)
            cell.pushBlock = {[weak self] (model) in
                let storyBoard = UIStoryboard(name: "Item", bundle: nil)
                let itemViewController = storyBoard.instantiateViewController(withIdentifier: "ItemViewController") as! ItemViewController
                
                itemViewController.id = "\(model.id)"
                self?.present(itemViewController, animated: true, completion: nil)
            }
            cell.blockWithCoordinates = {[weak self] (longtitude, latitude) in
                let storyBoard = UIStoryboard(name: "Map", bundle: nil)
                let mapViewController = storyBoard.instantiateViewController(withIdentifier: "mapId") as! MapViewController
                mapViewController.viewWillAppear(true)
                mapViewController.locateMarker(longitude: longtitude, latitude: latitude)
                self?.present(mapViewController, animated: true, completion: nil)
            }


            return cell
        }
        
        return UITableViewCell()
    }
}
