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
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    
    var token = ""
    var userId = ""
    @IBAction func loginButton(_ sender: Any)
    {
        if (email.text != "") && (password.text != "")
            {
                LoginManager.authUserWithEmail(email: email.text!, password: password.text!, success: { [weak self] (userInfo) in
                 
                    DispatchQueue.main.async
                        {
                            
                        print("СРАБОТАЛА КНОПКА")
                        
                        let status = userInfo.0
                        self!.token = userInfo.1
                        self!.userId = userInfo.2
                            
                            if status == "true"
                            {
                                self?.performSegue(withIdentifier: "loginSegue", sender: nil) // 4
                            }
                                
                            else
                            {
                                let alert = UIAlertController(title: "Ошибка", message: "Неправильный логин или пароль", preferredStyle: UIAlertControllerStyle.alert)
                                alert.addAction(UIAlertAction(title: "Ввести заново", style: UIAlertActionStyle.cancel, handler: nil))
                                self?.present(alert, animated: true, completion: nil)
                            }
                        }
                    }, failure: {errorCode in
                })
            }
        else
        {
            let alert = UIAlertController(title: "Ошибка", message: "Не заполнены поля логин и пароль", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Назад", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "loginSegue"
        {
        //print("ТОКЕН в ЛОГИН - \(token)")
            let barViewControllers = segue.destination as! UITabBarController
            let nav = barViewControllers.viewControllers![0] as! UINavigationController
            let destinationViewController = nav.viewControllers[0] as! MapViewController
            destinationViewController.userToken = token
            destinationViewController.userId = userId
            
        }
    }
}
