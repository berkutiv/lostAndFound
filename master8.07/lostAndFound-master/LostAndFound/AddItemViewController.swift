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
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

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
    @IBOutlet weak var createButton: UIButton!

    var myLocation = CLLocation()
    var itemAdress = ""
    var myLatitude = String()
    var myLongitude = String()
    var id = 1
    var buttonPressed = Int()
    let photos = NSMutableArray()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        photoButton.setImage(#imageLiteral(resourceName: "camerаIcon"), for: .normal)
        photoButton1.setImage(#imageLiteral(resourceName: "camerаIcon"), for: .normal)
        photoButton2.setImage(#imageLiteral(resourceName: "camerаIcon"), for: .normal)
        photoButton3.setImage(#imageLiteral(resourceName: "camerаIcon"), for: .normal)
        
        createButton.backgroundColor = .clear
        createButton.layer.cornerRadius = 5
        createButton.layer.borderWidth = 1
        createButton.layer.borderColor = UIColor.black.cgColor
        
        mapButton.layer.cornerRadius = 5
        
        itemDescriptionTextView.setContentOffset(CGPoint.zero, animated: false)
        itemNameTextField.delegate = self
        itemRewardTextFiled.delegate = self
        
//        itemNameTextField.setLeftPaddingPoints(15)
//        itemRewardTextFiled.setLeftPaddingPoints(15)
    
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddItemViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(AddItemViewController.keyboardWillShow(sender: )), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AddItemViewController.keyboardWillHide(sender:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        //Настройки навигационника
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.topItem?.title = "Создать объявление"
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.black
        let backButton = UIBarButtonItem(title: "Назад", style:.plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButton
        //
        
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLayoutSubviews()
    {
        itemNameTextField.underlined()
        itemRewardTextFiled.underlined()
        super.viewDidLayoutSubviews()
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
        if itemNameTextField.text! == ""
        {
            enterItemNameAlert()
        }
        else
        {
            buttonPressed = 0
            
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            actionSheet.addAction(UIAlertAction(title: "Камера", style: .default, handler: {
                action in
                self.showCamera()
            }))
            
            actionSheet.addAction(UIAlertAction(title: "Мои фотографии", style: .default, handler: {
                action in
                self.showAlbum()
            }))
            
            actionSheet.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: {
                action in
                self.photoButton.setImage(#imageLiteral(resourceName: "camerаIcon"), for: .normal)
            }))
            
            actionSheet.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
            
            self.present(actionSheet, animated: true, completion: nil)
        }
    }
    
    @IBAction func photoButton1(_ sender: Any)
    {
        if itemNameTextField.text! == ""
        {
            enterItemNameAlert()
        }
        else
        {
        buttonPressed = 1

        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Камера", style: .default, handler: {
            action in
            self.showCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Мои фотографии", style: .default, handler: {
            action in
            self.showAlbum()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: {
            action in
            self.photoButton1.setImage(#imageLiteral(resourceName: "camerаIcon"), for: .normal)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
        }
    }
    
    @IBAction func photoButton2(_ sender: UIButton)
    {
        if itemNameTextField.text! == ""
        {
            enterItemNameAlert()
        }
        else
        {
        buttonPressed = 2
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        
        actionSheet.addAction(UIAlertAction(title: "Камера", style: .default, handler: {
            action in
            self.showCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Мои фотографии", style: .default, handler: {
            action in
            self.showAlbum()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: {
            action in
            self.photoButton2.setImage(#imageLiteral(resourceName: "camerаIcon"), for: .normal)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
        }
    }
    
    @IBAction func photoButton3(_ sender: Any)
    {
        if itemNameTextField.text! == ""
        {
            enterItemNameAlert()
        }
        else
        {

        buttonPressed = 3
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Камера", style: .default, handler: {
            action in
            self.showCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Мои фотографии", style: .default, handler: {
            action in
            self.showAlbum()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: {
            action in
            self.photoButton3.setImage(#imageLiteral(resourceName: "camerаIcon"), for: .normal)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
        }
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
        if buttonPressed == 0
        {
            photoButton.setImage(image, for: .normal)
            
            uploadMedia(image: image, buttonnumber: buttonPressed, itemName: itemNameTextField.text!, completion: { (url) in
              
                print("URL фотографии - \(url)")
                self.photos.add(url!)
            })
            
            self.dismiss(animated: true, completion: nil)
          }
        else if buttonPressed == 1
        {
            photoButton1.setImage(image, for: .normal)
            
            uploadMedia(image: image, buttonnumber: buttonPressed, itemName: itemNameTextField.text!, completion: { (url) in
                
                print("URL фотографии - \(url)")
                self.photos.add(url!)
            })
            
            self.dismiss(animated: true, completion: nil)
        }
        else if buttonPressed == 2
        {
            photoButton2.setImage(image, for: .normal)
            
            uploadMedia(image: image, buttonnumber: buttonPressed, itemName: itemNameTextField.text!, completion: { (url) in
                
                print("URL фотографии - \(url)")
                self.photos.add(url!)
            })
            
            self.dismiss(animated: true, completion: nil)
        }
        else if buttonPressed == 3
        {
            photoButton3.setImage(image, for: .normal)
            
            uploadMedia(image: image, buttonnumber: buttonPressed, itemName: itemNameTextField.text!, completion: { (url) in
                
                print("URL фотографии - \(url)")
                self.photos.add(url!)
            })
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        dismiss(animated: true, completion: nil)
    }
    
    func setLocation(adress: String, latitude: String, longitude: String)
    {
        print("Мой адрес сегодня такой - \(adress)")
        itemAdress = adress
        myLongitude = longitude
        myLatitude = latitude
        mapButton.setTitle(adress, for: .normal)
        mapButton.titleLabel?.minimumScaleFactor = 0.5
        mapButton.titleLabel?.numberOfLines = 0
        mapButton.titleLabel?.adjustsFontSizeToFitWidth = true
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
    
    @IBAction func addItemAction(_ sender: Any)
    {
        if (itemNameTextField.text != "")
        {
            if (itemRewardTextFiled.text != "")
            {
                if (mapButton.titleLabel?.text != "Указать местоположение")
                {
                    if (photoButton.currentImage == #imageLiteral(resourceName: "camerаIcon")) || (photoButton1.currentImage == #imageLiteral(resourceName: "camerаIcon")) || (photoButton2.currentImage == #imageLiteral(resourceName: "camerаIcon")) || (photoButton3.currentImage == #imageLiteral(resourceName: "camerаIcon"))
                    {
                        
                        let userId : String = UserDefaults.standard.value(forKey: "uid") as! String
                        let userToken : String = UserDefaults.standard.value(forKey: "utoken") as! String
                        
                        AddManager.addItem(token: userToken, userId: userId, itemName: itemNameTextField.text!, itemDescription: itemDescriptionTextView.text!, itemLatitude: myLatitude, itemLongitude: myLongitude, itemAdress: itemAdress, itemReward: itemRewardTextFiled.text!, photos : photos, success: { [weak self] (response) in
                            
                            DispatchQueue.main.async
                                {
                                    let addSuccess = response
                                    
                                    if (addSuccess == "true")
                                    {
                                        let alert = UIAlertController(title: "Объявление создано", message: nil, preferredStyle: UIAlertControllerStyle.alert)
                                        
                                        
                                        let confirmAction = UIAlertAction(title: "Продолжить", style: UIAlertActionStyle.default) { (action) in
                                            
                                            
                                            self?.itemNameTextField.text = ""
                                            self?.itemDescriptionTextView.text = ""
                                            self?.itemRewardTextFiled.text = ""
                                            self?.mapButton.setTitle("Изменить местоположение", for: .normal)
                                            
                                            self?.photoButton.setImage(#imageLiteral(resourceName: "camerаIcon"), for: .normal)
                                            self?.photoButton1.setImage(#imageLiteral(resourceName: "camerаIcon"), for: .normal)
                                            self?.photoButton2.setImage(#imageLiteral(resourceName: "camerаIcon"), for: .normal)
                                            self?.photoButton3.setImage(#imageLiteral(resourceName: "camerаIcon"), for: .normal)
                                            
                                            self?.photos.removeAllObjects()
                                            
                                            self?.tabBarController?.selectedIndex = 0
                                            
                                        }
                                        
                                        alert.addAction(confirmAction)
                                        self?.present(alert, animated: true, completion: nil)
                                    }
                            }
                            
                            }, failure: {(errorCode) in
                                
                        })
                    }
                    else
                    {
                        let alert = UIAlertController(title: "Ошибка", message: "Добавьте хотя бы одну фотографию", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Назад", style: UIAlertActionStyle.cancel, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                else
                {
                    let alert = UIAlertController(title: "Ошибка", message: "Укажите местоположение", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Назад", style: UIAlertActionStyle.cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
            else
            {
                let alert = UIAlertController(title: "Ошибка", message: "Укажите награду за находку вещи (Например: угостить кофе)", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Назад", style: UIAlertActionStyle.cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        else
        {
            let alert = UIAlertController(title: "Ошибка", message: "Введите название вещи", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Назад", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

//Вспомогательные функции

extension AddItemViewController
{
    func uploadMedia(image : UIImage, buttonnumber : Int, itemName : String, completion: @escaping (_ url: String?) -> Void)
    {
        let storageRef = FIRStorage.storage().reference().child("itemsPics/\(itemName)/\(buttonnumber)")
        
        let metadata = FIRStorageMetadata()
        metadata.contentType = "image/jpeg"
        
        if let uploadData = UIImageJPEGRepresentation(image, 0.2) {
            storageRef.put(uploadData, metadata: metadata) { (metadata, error) in
                if error != nil
                {
                    print("error")
                    completion(nil)
                }
                else
                {
                    completion((metadata?.downloadURL()?.absoluteString))
                    // your uploaded photo url.
                }
            }
        }
    }
    
    func enterItemNameAlert ()
    {
        let actionSheet = UIAlertController(title: "Ошибка", message: "Введите название вещи", preferredStyle: UIAlertControllerStyle.alert)
        
        
        actionSheet.addAction(UIAlertAction(title: "Назад", style: UIAlertActionStyle.cancel, handler: {
        action in
            
            self.itemNameTextField.becomeFirstResponder()
            
        }))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
}

extension UITextField
{
    func underlined()
    {
        let borderBottom = CALayer()
        let borderWidth = CGFloat(1.0)
        borderBottom.borderColor = UIColor.groupTableViewBackground.cgColor
        borderBottom.frame = CGRect(x: 0, y: self.frame.height - 1.0, width: self.frame.width, height: self.frame.height - 1.0)
        borderBottom.borderWidth = borderWidth
        self.layer.addSublayer(borderBottom)
        self.layer.masksToBounds = true
    }
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}



