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

class AddItemViewController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var photoButton1: UIButton!
    @IBOutlet weak var photoButton2: UIButton!
    @IBOutlet weak var photoButton3: UIButton!

    var id = 1
    var buttonPressed = Int()
  
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func mapButton(_ sender: Any)
    {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Add", bundle: nil)
        let initViewController: UIViewController = storyBoard.instantiateViewController(withIdentifier: "SetLocationViewController") as! SetLocationViewController
        self.present(initViewController,animated: false, completion: nil)
    }
    
    @IBAction func photoButton(_ sender: Any)
    {
        buttonPressed = 1
        let actionSheet = UIAlertController(title: "New Photo", message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {
            action in
            self.showCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Album", style: .default, handler: {
            action in
            self.showAlbum()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)

    }
    
    @IBAction func photoButton1(_ sender: Any)
    {
        buttonPressed = 2

        let actionSheet = UIAlertController(title: "New Photo", message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {
            action in
            self.showCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Album", style: .default, handler: {
            action in
            self.showAlbum()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func photoButton2(_ sender: Any)
    {
        buttonPressed = 3
        let actionSheet = UIAlertController(title: "New Photo", message: nil, preferredStyle: .actionSheet)
        
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {
            action in
            self.showCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Album", style: .default, handler: {
            action in
            self.showAlbum()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func photoButton3(_ sender: Any)
    {
        buttonPressed = 4
        let actionSheet = UIAlertController(title: "New Photo", message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {
            action in
            self.showCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Album", style: .default, handler: {
            action in
            self.showAlbum()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
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
}


