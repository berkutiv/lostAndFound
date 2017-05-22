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
    @IBOutlet var itemMapView: GMSMapView!
    var latitude = CLLocationDegrees()
    var longitude = CLLocationDegrees()

    var myView = GMSMapView()
    var camera = GMSCameraPosition()    
    
    func configureSelf (withDataModel model : ItemMapModel)
    {
        latitude = model.latitude
        longitude = model.longitude
       
        let frame = CGRect(x: 0, y: 0, width: 414, height: 320)
        let camera = GMSCameraPosition.camera(withLatitude: latitude,
                                              longitude: longitude,
                                              zoom: 14)
        
        myView = GMSMapView.map(withFrame: frame, camera: camera)
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: camera.target.latitude, longitude: camera.target.longitude)
        marker.appearAnimation = kGMSMarkerAnimationPop
        marker.icon = UIImage(named: "flag_icon")
        marker.map = myView
        self.itemMapView.addSubview(myView)
    }
}
