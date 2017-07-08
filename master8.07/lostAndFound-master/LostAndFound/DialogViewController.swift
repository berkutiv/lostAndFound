//
//  DialogViewController.swift
//  LostAndFound
//
//  Created by Орлов Максим on 22.05.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import UIKit

class DialogViewController : UIViewController
{
    var userChatID = "no id"
    var userChatName = "no name"
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        navigationItem.title = userChatName
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func backButton(_ sender: Any)
    {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Chat", bundle: nil)
        let initViewController: UIViewController = storyBoard.instantiateViewController(withIdentifier: "chatId") as! ChatViewController
        
        self.present(initViewController,animated: false, completion: nil)
    }
}
