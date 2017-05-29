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
    @IBOutlet weak var mapButton: UIButton!
    var coordinatesBlock: ((String, String) -> Void)!
    var model = Item(id: "", title: "", description: "", photosURL: [], longitude: "1", latitude: "1", userId: "")

    override func awakeFromNib()
    {
        super.awakeFromNib()
        mapButton.layer.cornerRadius = self.mapButton.frame.width/18.0
        mapButton.layer.masksToBounds = true
    }

    func configureSelf(model: Item)
    {
        self.model = model
        self.picture.sd_setImage(with: URL(string: "https://pp.userapi.com/c543103/v543103306/1f74c/q6hK2NFOUqo.jpg"))
        self.titleLabel.text = model.title
        picture.layer.cornerRadius = self.picture.frame.width/2.0
        picture.layer.masksToBounds = true
    }
    
    @IBAction func buttonPressed(_ sender: Any)
    {
        let model = self.model
        print("long \(model.longitude)")
        coordinatesBlock(model.longitude, model.latitude)
    }
   
}
