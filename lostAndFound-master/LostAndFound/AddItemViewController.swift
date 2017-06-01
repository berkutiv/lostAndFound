//
//  AddItemViewController.swift
//  LostAndFound
//
//  Created by Орлов Максим on 22.04.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps

class AddItemViewController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate, BackCoordinates
{
    @IBOutlet weak var itemDescriptionTextView: UITextView!
    @IBOutlet weak var itemRewardTextFiled: UITextField!
    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var photoButton1: UIButton!
    @IBOutlet weak var photoButton2: UIButton!
    @IBOutlet weak var photoButton3: UIButton!
    
    var myLocation = CLLocation()
    var id = 1
    var buttonPressed = Int()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        itemDescriptionTextView.setContentOffset(CGPoint.zero, animated: false)
        itemNameTextField.delegate = self
        itemRewardTextFiled.delegate = self

        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddItemViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(AddItemViewController.keyboardWillShow(sender: )), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AddItemViewController.keyboardWillHide(sender:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        //Настройки навигационника
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.topItem?.title = "Добавить"
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.black
        let backButton = UIBarButtonItem(title: "Назад", style:.plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButton
        //
        
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews()
    {
        let borderBottom = CALayer()
        let borderWidth = CGFloat(2.0)
        borderBottom.borderColor = UIColor.gray.cgColor
        borderBottom.frame = CGRect(x: 0, y: itemNameTextField.frame.height - 1.0, width: itemNameTextField.frame.width , height: itemNameTextField.frame.height - 1.0)
        borderBottom.borderWidth = borderWidth
        itemNameTextField.layer.addSublayer(borderBottom)
        itemNameTextField.layer.masksToBounds = true
        
        let borderBottom2 = CALayer()
        let borderWidth2 = CGFloat(2.0)
        borderBottom2.borderColor = UIColor.gray.cgColor
        borderBottom2.frame = CGRect(x: 0, y: itemRewardTextFiled.frame.height - 1.0, width: itemRewardTextFiled.frame.width , height: itemRewardTextFiled.frame.height - 1.0)
        borderBottom2.borderWidth = borderWidth2
        itemRewardTextFiled.layer.addSublayer(borderBottom2)
        itemRewardTextFiled.layer.masksToBounds = true
    }
}
//MARK: Клавиатура и текстфилд
extension AddItemViewController
{
    func keyboardWillShow(sender: NSNotification)
    {
        self.view.frame.origin.y = -80 // Move view 150 points upward
    }
    
    func keyboardWillHide(sender: NSNotification)
    {
        self.view.frame.origin.y = 0 // Move view to original position
    }
    
    func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField
        {
            nextField.becomeFirstResponder()
        }
        else if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextView
        {
            nextField.setContentOffset(CGPoint.zero, animated: false)
            nextField.becomeFirstResponder()
        }
            
        else {
            
            textField.resignFirstResponder()
        }
        return true
    }
}

//MARK : Кнопки с фотографиями, методы и процедуры ImagePicker
extension AddItemViewController
{
    @IBAction func photoButton(_ sender: Any)
    {
        buttonPressed = 1
        let actionSheet = UIAlertController(title: "New Photo", message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Камера", style: .default, handler: {
            action in
            self.showCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Мои фотографии", style: .default, handler: {
            action in
            self.showAlbum()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Удалить", style: .default, handler: {
            action in
            self.photoButton.setImage(UIImage(named: "w512h5121347464802Pictures"), for: .normal)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func photoButton1(_ sender: Any)
    {
        buttonPressed = 2

        let actionSheet = UIAlertController(title: "New Photo", message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Камера", style: .default, handler: {
            action in
            self.showCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Мои фотографии", style: .default, handler: {
            action in
            self.showAlbum()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Удалить", style: .default, handler: {
            action in
            self.photoButton1.setImage(UIImage(named: "w512h5121347464802Pictures"), for: .normal)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func photoButton2(_ sender: Any)
    {
        buttonPressed = 3
        let actionSheet = UIAlertController(title: "New Photo", message: nil, preferredStyle: .actionSheet)
        
        
        actionSheet.addAction(UIAlertAction(title: "Камера", style: .default, handler: {
            action in
            self.showCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Мои фотографии", style: .default, handler: {
            action in
            self.showAlbum()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Удалить", style: .default, handler: {
            action in
            self.photoButton2.setImage(UIImage(named: "w512h5121347464802Pictures"), for: .normal)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func photoButton3(_ sender: Any)
    {
        buttonPressed = 4
        let actionSheet = UIAlertController(title: "New Photo", message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Камера", style: .default, handler: {
            action in
            self.showCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Мои фотографии", style: .default, handler: {
            action in
            self.showAlbum()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Удалить", style: .default, handler: {
            action in
            self.photoButton3.setImage(UIImage(named: "w512h5121347464802Pictures"), for: .normal)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
  

    func showCamera()
    {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .camera
        present(cameraPicker, animated: true, completion: nil)
    }
    
    func showAlbum()
    {
        let albumPicker = UIImagePickerController()
        albumPicker.delegate = self
        albumPicker.sourceType = .photoLibrary
        present(albumPicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [NSObject : AnyObject]!)
    {
        print(buttonPressed)
        if buttonPressed == 1
        {
            photoButton.setImage(image, for: .normal)
            self.dismiss(animated: true, completion: nil)
          }
        else if buttonPressed == 2
        {
            photoButton1.setImage(image, for: .normal)
            self.dismiss(animated: true, completion: nil)
        }
        else if buttonPressed == 3
        {
            photoButton2.setImage(image, for: .normal)
            self.dismiss(animated: true, completion: nil)
        }
        else if buttonPressed == 4
        {
            photoButton3.setImage(image, for: .normal)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        dismiss(animated: true, completion: nil)
    }
    
    func setLocation(adress: String)
    {
        print("Мой адрес сегодня такой - \(adress)")
        mapButton.setTitle(adress, for: .normal)
    }
}
//MARK: Программный переход в SetLocationViewController
extension AddItemViewController
{
    @IBAction func mapButton(_ sender: Any)
    {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Add", bundle: nil)
        let initViewController = storyBoard.instantiateViewController(withIdentifier: "SetLocationViewController") as! SetLocationViewController
        initViewController.delegate = self
        
        navigationController?.pushViewController(initViewController, animated: true)
    }
}


