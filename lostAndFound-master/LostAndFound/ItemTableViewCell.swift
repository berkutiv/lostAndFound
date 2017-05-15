//
//  ItemTableViewCell.swift
//  LostAndFound
//
//  Created by Иван on 25.04.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import UIKit
import SDWebImage

class ItemTableViewCell: UITableViewCell
{
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    

    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    func configureSelf(model: Item)
    {
        self.picture.sd_setImage(with: URL(string: "https://pp.userapi.com/c543103/v543103306/1f74c/q6hK2NFOUqo.jpg"))
        self.titleLabel.text = model.title
        picture.layer.cornerRadius = self.picture.frame.width/2.0
        picture.layer.masksToBounds = true
    }
   
}
