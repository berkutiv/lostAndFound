//
//  LoginViewController.swift
//  LostAndFound
//
//  Created by Орлов Максим on 01.06.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController
{
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var userName: UITextField!
    
    
    @IBAction func loginButton(_ sender: Any)
    {
        if userName?.text != "" { // 1
            
            
            FIRAuth.auth()?.signInAnonymously(completion: { (user, error) in // 2
                if let err = error { // 3
                    print(err.localizedDescription)
                    return
                }
                let senderId = FIRAuth.auth()?.currentUser?.uid
                print(senderId)
                self.performSegue(withIdentifier: "loginSegue", sender: nil) // 4
            })
        }
    }
    
}
