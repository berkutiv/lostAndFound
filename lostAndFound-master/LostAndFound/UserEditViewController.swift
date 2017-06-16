//
//  UserEditViewController.swift
//  LostAndFound
//
//  Created by Иван on 14.06.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import UIKit

class UserEditViewController: UIViewController
{
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var mailField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    var model = UserHeader(id: "", name: "", phone: "", email: "", photo: "")
    
    override func viewDidLoad()
    {
        nameField.text = model.name
    }
    
    @IBAction func save(_ sender: Any)
    {
        model.name = nameField.text!
        
        UsersFactory.setUser(user: model)
        
        let storyBoard = UIStoryboard(name: "Profile", bundle: nil)
        let userPageViewController = storyBoard.instantiateViewController(withIdentifier: "profileId") as! UserPageViewController
        
        
        self.navigationController?.pushViewController(userPageViewController, animated: false)
    }

}
