//
//  ItemHeaderTableViewCell.swift
//  LostAndFound
//
//  Created by Орлов Максим on 18.05.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import UIKit

class ItemHeaderTableViewCell: UITableViewCell
{
    
    @IBOutlet weak var itemReward: UILabel!
    
    func configureSelf (withDataModel model : ItemHeaderModel)
    {
        itemReward.text = model.itemReward
    }
}
