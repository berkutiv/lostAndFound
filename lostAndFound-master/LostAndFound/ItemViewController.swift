//
//  ItemViewController.swift
//  LostAndFound
//
//  Created by Иван on 16.05.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController
{
    @IBOutlet weak var tableView: UITableView!

    var id = "no id"
    var presenter : Presenter?
    
    let kItemDescriptionNib = UINib(nibName: "ItemDescriptionTableViewCell", bundle: nil)
    let kItemDescriptionReusableIdentifier = "kItemDescriptionReusableIdentifier"
    
    override func viewDidLoad()
    {
        DependencyInjector.obtainPresenter(view: self)
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 40
        tableView.register(kItemDescriptionNib, forCellReuseIdentifier: kItemDescriptionReusableIdentifier)

    }
}

extension ItemViewController : View
{
    /**
     назначение презентера
     */
    func assignPresenter(presenter: Presenter) -> Void
    {
        self.presenter = presenter
        
        let customData = NSMutableDictionary()
        customData.setValue(id, forKey: "item_id")
        
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

extension ItemViewController : UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return (presenter?.numberOfSections())!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        print  ("Количество моделей - \(presenter?.numberOfModels(inSection: section))")
        return (presenter?.numberOfModels(inSection: section))!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
       
        if let model = presenter?.model(at: indexPath) as? ItemDescriptionModel
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: kItemDescriptionReusableIdentifier, for: indexPath) as! ItemDescriptionTableViewCell
            
            cell.configureSelf(withDataModel: model)
            
            return cell
        }
        
        return UITableViewCell()
    }
}






