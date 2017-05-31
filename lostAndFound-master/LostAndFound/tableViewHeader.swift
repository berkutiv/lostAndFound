//
//  tableViewHeader.swift
//  LostAndFound
//
//  Created by Иван on 26.04.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import Foundation
import UIKit



class tableViewHeader: UIView
{
    @IBOutlet weak var smallDragger: UIView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        smallDragger.layer.cornerRadius = self.smallDragger.frame.width/10.0
        smallDragger.layer.masksToBounds = true
    }
}
