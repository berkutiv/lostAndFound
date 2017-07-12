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
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    let kUserHeaderNIB = UINib(nibName: "UserHeaderTableViewCell", bundle: nil)
    let kUserHeaderReuseIdentifier = "kUserHeaderReuseIdentifier"
    
    let kUserTableNIB = UINib(nibName: "UserTableTableViewCell", bundle: nil)
    let kUserTableReuseIdentifier = "kUserTableReuseIdentifier"
    
    let kUserButtonsNIB = UINib(nibName: "UserButtonsTableViewCell", bundle: nil)
    let kUserButtonsReuseIdentifier = "kUserButtonsReuseIdentifier"
    
    let kItemCellNIB = UINib(nibName: "ItemTableViewCell", bundle: nil)
    let kItemCellReuseIdentifier = "kItemCellReuseIdentifier"
    
    var presenter: Presenter?    
    var id = UserDefaults.standard.value(forKey: "uid") as! String
    var blockWithCoordinates: ((String, String) -> Void)!
    
    override func viewWillAppear(_ animated: Bool)
    {
            //Настройки навигационника
            self.navigationController?.isNavigationBarHidden = true
//            self.navigationController?.navigationBar.topItem?.title = "Создать объявление"
//            self.navigationController?.navigationBar.barTintColor = UIColor.white
            self.navigationController?.navigationBar.tintColor = UIColor.black
            let backButton = UIBarButtonItem(title: "Назад", style:.plain, target: nil, action: nil)
            self.navigationItem.backBarButtonItem = backButton
            //
        
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
        tableView.register(kUserHeaderNIB, forCellReuseIdentifier: kUserHeaderReuseIdentifier)
        tableView.register(kUserTableNIB, forCellReuseIdentifier: kUserTableReuseIdentifier)
        tableView.register(kUserButtonsNIB, forCellReuseIdentifier: kUserButtonsReuseIdentifier)
        tableView.register(kItemCellNIB, forCellReuseIdentifier: kItemCellReuseIdentifier)
    }
}

extension UserPageViewController: View
{
    func assignPresenter(presenter: Presenter) -> Void
    {
        tableView.dataSource = self
        tableView.delegate = self
        self.presenter = presenter
        
        let customData = NSMutableDictionary()
        customData.setValue(id, forKey: "user_id")
        presenter.provide(data: customData)
        
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
        return (presenter!.getModel(by: id) as! User).modelsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let model = (presenter!.model(at: indexPath))
        print("model \(model)")
        
        if model is UserHeader
        {
            print("хэдер тут")
            let cell = tableView.dequeueReusableCell(withIdentifier: kUserHeaderReuseIdentifier, for: indexPath) as! UserHeaderTableViewCell
            cell.configureSelf(withDataModel: model as! UserHeader)
            cell.editBlock = {[weak self] (model) in
                    let storyBoard = UIStoryboard(name: "Profile", bundle: nil)
                    let editUserViewController = storyBoard.instantiateViewController(withIdentifier: "userEdit") as! UserEditViewController
                    
                    editUserViewController.model = model
                    self?.navigationController?.pushViewController(editUserViewController, animated: false)
            }
            backgroundImage.image = UIImage(named: (model as! UserHeader).photo)
            backgroundImage.image = UIImage(named: "1")
            blur()
            return cell
        }
        if model is UserButtons
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: kUserButtonsReuseIdentifier, for: indexPath) as! UserButtonsTableViewCell
            cell.configureSelf(withDataModel: model as! UserButtons)
            return cell
        }
        if model is UserItem
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: kItemCellReuseIdentifier, for: indexPath) as! ItemTableViewCell
            
            cell.configureSelf(model: (model as! UserItem).item)
            cell.coordinatesBlock = {[weak self] (longtitude, latitude) in
                print("в блоке")
//                self?.blockWithCoordinates(model.longitude, model.latitude)
//                self?.hideTable()
//                tableView.isScrollEnabled = false
//                var indexPath = IndexPath(item: 0, section: 0)
//                tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
            }

//            cell.pushBlock = {[weak self] (model) in
//                let storyBoard = UIStoryboard(name: "Item", bundle: nil)
//                let itemViewController = storyBoard.instantiateViewController(withIdentifier: "ItemViewController") as! ItemViewController
//                
//                itemViewController.id = "\(model.id)"
//                self?.present(itemViewController, animated: true, completion: nil)
//            }
//            cell.blockWithCoordinates = {[weak self] (longtitude, latitude) in
//                let storyBoard = UIStoryboard(name: "Map", bundle: nil)
//                let mapViewController = storyBoard.instantiateViewController(withIdentifier: "mapId") as! MapViewController
//                mapViewController.viewWillAppear(true)
//                mapViewController.locateMarker(longitude: longtitude, latitude: latitude)
//                self?.present(mapViewController, animated: true, completion: nil)
//            }


            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let model = (presenter!.getModel(by: id) as! User).modelsArray[indexPath.row]
        
        if model is UserItem
        {
            let storyBoard = UIStoryboard(name: "Item", bundle: nil)
            let itemViewController = storyBoard.instantiateViewController(withIdentifier: "ItemViewController") as! ItemViewController
            
            itemViewController.id = "\((model as! UserItem).item.id)"
            
            navigationController?.pushViewController(itemViewController, animated: true)
        }
    }
}

extension UserPageViewController
{
    func blur()
    {
        let darkBlur = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurView = UIVisualEffectView(effect: darkBlur)
        blurView.frame = backgroundImage.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundImage.addSubview(blurView)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        //print("scrooll\(scrollView.contentOffset.y)")
        if scrollView.contentOffset.y < 0
        {
            self.backgroundImage.transform = CGAffineTransform(scaleX: 1 - scrollView.contentOffset.y/120, y: 1 - scrollView.contentOffset.y/120)
        }else
        {
            self.backgroundImage.transform = CGAffineTransform.identity
        }
    }

}
