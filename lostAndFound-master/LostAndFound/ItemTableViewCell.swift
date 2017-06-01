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
    @IBOutlet weak var buttonPin: UIButton!
    
    
    var coordinatesBlock: ((String, String) -> Void)!
    var model = Item(id: "", title: "", description: "", photosURL: [], longitude: "1", latitude: "1", userId: "")

   
    func configureSelf(model: Item)
    {
        self.model = model
        print("photo \(model.photosURL[0])")
        self.picture.image = UIImage(named: "\(model.photosURL[0])")
        self.titleLabel.text = model.title
        picture.layer.cornerRadius = self.picture.frame.width/6.4
        picture.layer.masksToBounds = true
        buttonPin.layer.borderWidth = 1
        buttonPin.layer.cornerRadius = self.buttonPin.frame.width/18
        buttonPin.layer.masksToBounds = true
    }
    
    @IBAction func buttonPressed(_ sender: Any)
    {
        let model = self.model
        print("long \(model.longitude)")
        coordinatesBlock(model.longitude, model.latitude)
    }
}
