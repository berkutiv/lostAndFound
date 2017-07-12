//
//  ChatViewController.swift
//  LostAndFound
//
//  Created by Иван on 26.04.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UINavigationControllerDelegate
{
    @IBOutlet weak var tableView: UITableView!
    var userID = "no id"
    var presenter : Presenter?
    
    let kChatTableViewCell = UINib(nibName: "ChatTableViewCell", bundle: nil)
    let kChatTableViewReuseIdentifier = "kChatTableViewReuseIdentifier"
    
    
    override func viewDidLoad()
    {
        self.tabBarController?.tabBar.isHidden = false
        
        DependencyInjector.obtainPresenter(view: self)
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 40
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.register(kChatTableViewCell, forCellReuseIdentifier: kChatTableViewReuseIdentifier)
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        //Настройки навигационника
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.topItem?.title = "Сообщения"
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.black
        let backButton = UIBarButtonItem(title: "Назад", style:.plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButton
        //
        
        super.viewWillAppear(animated)
    }
}

extension ChatViewController : View
{
    /**
     назначение презентера
     */
    func assignPresenter(presenter: Presenter) -> Void
    {
        self.presenter = presenter
        
        let customData = NSMutableDictionary()
        customData.setValue(userID, forKey: "user_id")
        
        presenter.provide(data: customData)
        
        presenter.viewLoaded(view: self)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    /**
     перезагрузка экрана
     */
    func reloadData() -> Void
    {
        tableView.reloadData()
    }
    
    /**
     включение loader'a
     */
    func addLoader() -> Void
    {
        
    }
    
    /**
     выключение loader'a
     */
    func removeLoader() -> Void
    {
        
    }
    
    /**
     коды ошибок интернета
     */
    func handleInternetErrorCode(code: Int) -> Void
    {
        
    }
}

extension ChatViewController : UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return (presenter?.numberOfSections())!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (presenter?.numberOfModels(inSection: section))!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if let model = presenter?.model(at: indexPath) as? Chat
        {
        let cell = tableView.dequeueReusableCell(withIdentifier: kChatTableViewReuseIdentifier, for: indexPath) as! ChatTableViewCell
        
        cell.configureSelf(withDataModel: model)
        
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let cell = presenter?.model(at: indexPath) as? Chat
        print("нажали")
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Chat", bundle: nil)
        let dialogViewController = storyBoard.instantiateViewController(withIdentifier: "DialogViewController") as! DialogViewController
        
        dialogViewController.userChatName = (cell?.chatUserName)!
        
        navigationController?.pushViewController(dialogViewController, animated: true)
    }
}














