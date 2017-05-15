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
    var user = User(id: "", name: "", phone: "", email: "", photo: "")
    
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
        self.navigationController?.title = "Друзья"
        tableView.estimatedRowHeight = 40.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedSectionHeaderHeight = 50
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        user = presenter!.getModel(atIndexPath: IndexPath(item: 0, section: 0)) as! User
    }
}

extension UserPageViewController: View
{
    func assignPresenter(presenter: Presenter) -> Void
    {
        self.presenter = presenter
        presenter.viewLoaded(view: self)
        tableView.dataSource = self
        tableView.delegate = self
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
    }
}
