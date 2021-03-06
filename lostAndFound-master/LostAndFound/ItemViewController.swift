//
//  ItemViewController.swift
//  LostAndFound
//
//  Created by Иван on 16.05.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController, UINavigationControllerDelegate
{
    @IBOutlet weak var tableView: UITableView!
    
    var id = "no id"
    var presenter : Presenter?
    
    
    let kItemPhotoCollectionNib = UINib(nibName: "ItemPhotoCollectionTableViewCell", bundle: nil)
    let kItemPhotoCollectionReuseIdentifier = "kItemPhotoCollectionReuseIdentifier"
    
    let kItemHeaderTableViewCellNib = UINib(nibName: "ItemHeaderTableViewCell", bundle: nil)
    let kItemHeaderTableViewCellReuseIdentifier = "kItemHeaderTableViewCellReuseIdentifier"
    
    let kItemMapTableViewCellNib = UINib(nibName: "ItemMapTableViewCell", bundle: nil)
    let kItemMapTableViewCellReuseIdentifier = "kItemMapTableViewCellReuseIdentifier"
    
    let kItemDescriptionNib = UINib(nibName: "ItemDescriptionTableViewCell", bundle: nil)
    let kItemDescriptionReusableIdentifier = "kItemDescriptionReusableIdentifier"
    
    let kItemContactsTableViewCellNib = UINib(nibName: "ItemContactsTableViewCell", bundle: nil)
    let kItemContactsTableViewCellReuseIdentifier = "kItemContactsTableViewCellReuseIdentifier"
    
    override func viewWillAppear(_ animated: Bool)
    {
        print("id вещи - \(id)")
        
        super.viewWillAppear(true)
        
        navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.black
        let backButton = UIBarButtonItem(title: "Назад", style:.plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButton
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if presenter == nil
        {
            DependencyInjector.obtainPresenter(view: self)
        }
        tableView.estimatedRowHeight = 40
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.register(kItemPhotoCollectionNib, forCellReuseIdentifier: kItemPhotoCollectionReuseIdentifier)
        tableView.register(kItemHeaderTableViewCellNib, forCellReuseIdentifier: kItemHeaderTableViewCellReuseIdentifier)
        tableView.register(kItemMapTableViewCellNib, forCellReuseIdentifier: kItemMapTableViewCellReuseIdentifier)
        tableView.register(kItemDescriptionNib, forCellReuseIdentifier: kItemDescriptionReusableIdentifier)
        tableView.register(kItemContactsTableViewCellNib, forCellReuseIdentifier: kItemContactsTableViewCellReuseIdentifier)
    }
}

extension ItemViewController : View
{
    /**
     назначение презентера
     */
    func assignPresenter(presenter: Presenter) -> Void
    {
        //        self.presenter = presenter
        //
        //        let customData = NSMutableDictionary()
        //        customData.setValue(id, forKey: "item_id")
        //
        //        presenter.provide(data: customData)
        //
        //        presenter.viewLoaded(view: self)
        //
        //        tableView.delegate = self
        //        tableView.dataSource = self
        tableView.dataSource = self
        tableView.delegate = self
        self.presenter = presenter
        presenter.viewLoadedWithID(id: id, view: self)
        
        tableView.reloadData()
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
        let alertController = UIAlertController(title: "Ошибка", message: "Нет соединения", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension ItemViewController : UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return (presenter?.numberOfSections())!
    }
    
    private func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (presenter?.numberOfModels(inSection: section))!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if let model = presenter?.model (at: indexPath) as? ItemPhotoCollectionModel
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: kItemPhotoCollectionReuseIdentifier, for: indexPath) as! ItemPhotoCollectionTableViewCell
            
            cell.configureSelf(withDataModel: model)
            
            return cell
        }
        
        if let model = presenter?.model(at: indexPath) as? ItemHeaderModel
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: kItemHeaderTableViewCellReuseIdentifier, for: indexPath) as!
            ItemHeaderTableViewCell
            
            cell.configureSelf(withDataModel: model)
            
            return cell
        }
        
        if let model = presenter?.model(at: indexPath) as? ItemMapModel
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: kItemMapTableViewCellReuseIdentifier, for: indexPath) as! ItemMapTableViewCell
            
            cell.configureSelf(withDataModel: model)
            
            return cell
        }
        
        if let model = presenter?.model(at: indexPath) as? ItemDescriptionModel
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: kItemDescriptionReusableIdentifier, for: indexPath) as! ItemDescriptionTableViewCell
            
            cell.configureSelf(withDataModel: model)
            
            return cell
        }
        
        if let model = presenter?.model(at: indexPath) as? ItemContactsModel
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: kItemContactsTableViewCellReuseIdentifier, for: indexPath) as! ItemContactsTableViewCell
            
            
            cell.chatButton.addTarget(self, action: #selector(ItemViewController.buttonClicked(_:)), for: .touchUpInside)
            cell.configureSelf(withDataModel: model)
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    @IBAction func backButton(_ sender: Any)
    {
        navigationController?.popViewController(animated: true)
    }
    
    func buttonClicked(_ sender: UIButton)
    {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Chat", bundle: nil)
        let dialogViewController = storyBoard.instantiateViewController(withIdentifier: "DialogViewController") as! DialogViewController
        
        self.navigationController?.pushViewController(dialogViewController, animated: true)
    }
}






