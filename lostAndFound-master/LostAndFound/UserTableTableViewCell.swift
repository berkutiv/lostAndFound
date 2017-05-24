//
//  UserTableTableViewCell.swift
//  LostAndFound
//
//  Created by Иван on 03.05.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import UIKit

class UserTableTableViewCell: UITableViewCell {

    @IBOutlet weak var tableView: UITableView!
    
    let kUserItemsNIB = UINib(nibName: "ItemTableViewCell", bundle: nil)
    let kUserItemsCellReuseIdentifier = "kUserItemsCellReuseIdentifier"
    
    var user = User(id: "", name: "", phone: "", email: "", photo: "")
    var pushBlock: ((Item) -> Void)!
    var blockWithCoordinates: ((String, String) -> Void)!
    
    func configureSelf(withDataModel model: User)
    {
        self.user = model
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 40.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedSectionHeaderHeight = 50
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        tableView.register(kUserItemsNIB, forCellReuseIdentifier: kUserItemsCellReuseIdentifier)
    }
}

extension UserTableTableViewCell: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return user.itemsCollection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: kUserItemsCellReuseIdentifier, for: indexPath) as! ItemTableViewCell
        let model = user.itemsCollection[indexPath.row] as! Item
        cell.configureSelf(model: model)
        cell.coordinatesBlock = {[weak self] (longtitude, latitude) in
            self?.blockWithCoordinates(model.longitude, model.latitude)
            var indexPath = IndexPath(item: 0, section: 0)
            tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let model = user.itemsCollection[indexPath.row] as! Item
        pushBlock(model)
    }
}
