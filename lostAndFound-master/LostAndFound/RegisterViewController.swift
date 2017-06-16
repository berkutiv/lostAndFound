//
//  RegisterViewController.swift
//  LostAndFound
//
//  Created by Орлов Максим on 12.06.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import UIKit

class RegisterViewController : UIViewController, UINavigationControllerDelegate
{
    @IBOutlet weak var userRepeatPassword: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userName: UITextField!
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        
        navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = UIColor.black

    }
    @IBAction func register(_ sender: UIButton)
    {
        if (userEmail.text != "") && (userPassword.text != "") && (userRepeatPassword.text != "") && (userName.text != "")
        {
            RegisterManager.createUserWithEmail(email: userEmail.text!, userName: userName.text!, password: userPassword.text!, passwordRepeat: userRepeatPassword.text!, success: { [weak self] (response) in
                
            DispatchQueue.main.async
            {
                
                let alert = response
                
                if (alert == "noAlert")
                {
                    let alert = UIAlertController(title: "Регистрация прошла успешно!", message: nil, preferredStyle: UIAlertControllerStyle.alert)
                    
                    
                    let confirmAction = UIAlertAction(title: "Продолжить", style: UIAlertActionStyle.default) { (action) in
                        self?.performSegue(withIdentifier: "registerCompleteSegue", sender: nil)
                    }
                    
                    alert.addAction(confirmAction)
                    self?.present(alert, animated: true, completion: nil)
                    
                    
                }
                else if (alert == "The email address is already in use by another account.")
                {
                    let alert = UIAlertController(title: "Ошибка", message: "Пользователь с таким email уже существует", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Назад", style: UIAlertActionStyle.cancel, handler: nil))
                    self?.present(alert, animated: true, completion: nil)
                }
                else if (alert == "Password not equal")
                {
                    let alert = UIAlertController(title: "Ошибка", message: "Повтор пароля введен неверно", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ввести заново", style: UIAlertActionStyle.cancel, handler: nil))
                    self?.present(alert, animated: true, completion: nil)
                }
                else if (alert == "The password must be a string with at least 6 characters.")
                {
                    let alert = UIAlertController(title: "Ошибка", message: "Длина пароля не менее 6 символов", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Назад", style: UIAlertActionStyle.cancel, handler: nil))
                    self?.present(alert, animated: true, completion: nil)
                }
            }
                
            }, failure: {(errorCode) in
            
            })
        }
        else
        {
            let alert = UIAlertController(title: "Ошибка", message: "Заполните все поля", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Назад", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    @IBAction func backButton(_ sender: Any)
    {
        navigationController?.popViewController(animated: true)
    }
}
