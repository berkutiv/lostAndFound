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
    let defaults = UserDefaults.standard
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        // If we have the uid stored, the user is already logger in - no need to sign in again!
        
        if UserDefaults.standard.value(forKey: "uid") != nil
        {
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.tintColor = UIColor.black
        let backButton = UIBarButtonItem(title: "Назад", style:.plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButton
    }
    
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
                                self?.defaults.set(self!.userId, forKey: "uid")
                                self?.defaults.set(self!.token, forKey: "utoken")
                                
//                                MapViewController.userId = self!.userId
//                                MapViewController.userToken = self!.token
                                
                                
                                self?.performSegue(withIdentifier: "loginSegue", sender: nil)
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
//            let barViewControllers = segue.destination as! UITabBarController
//            let nav = barViewControllers.viewControllers![0] as! UINavigationController
//            let destinationViewController = nav.viewControllers[0] as! MapViewController
//            destinationViewController.userToken = token
//            destinationViewController.userId = userId
        }
    }
    
    @IBAction func register(_ sender: Any)
    {
        self.performSegue(withIdentifier: "registerSegue", sender: nil)
    }
}


//let appDomain = Bundle.main.bundleIdentifier!
//UserDefaults.standard.removePersistentDomain(forName: appDomain)
//print(UserDefaults.standard.dictionaryRepresentation().keys.count)
