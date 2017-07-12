//
//  ItemMapTableViewCell.swift
//  LostAndFound
//
//  Created by Орлов Максим on 11.05.17.
//  Copyright © 2017 Иван. All rights reserved.
//


import UIKit
import GoogleMaps
import CoreLocation

class ItemMapTableViewCell: UITableViewCell
{
    @IBOutlet weak var itemMap: GMSMapView!
    @IBOutlet weak var itemAdress: UILabel!
    @IBOutlet weak var myView: GMSMapView!
    
    
    
    var longitude = CLLocationDegrees()
    var latitude = CLLocationDegrees()
    
    //var myView = GMSMapView()
    var camera = GMSCameraPosition()
    
    func configureSelf (withDataModel model : ItemMapModel)
    {
        latitude = model.latitude
        longitude = model.longitude
        itemAdress.text = model.itemAdress
        itemAdress.lineBreakMode = NSLineBreakMode.byWordWrapping
        itemAdress.numberOfLines = 0
        
        //let frame = CGRect(x: 66, y: 8 , width: itemMap.frame.size.width, height: itemMap.frame.size.height)
        let camera = GMSCameraPosition.camera(withLatitude: latitude,
                                              longitude: longitude,
                                              zoom: 15)
        
        myView.camera = camera
        // myView = GMSMapView.map(withFrame: frame, camera: camera)
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: camera.target.latitude, longitude: camera.target.longitude)
        marker.appearAnimation = kGMSMarkerAnimationPop
        marker.icon = UIImage(named: "flag_icon")
        marker.map = myView
        self.itemMap.addSubview(myView)
    }
}
