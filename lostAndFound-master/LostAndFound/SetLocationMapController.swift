//
//  SetLocationMapController.swift
//  LostAndFound
//
//  Created by Орлов Максим on 24.04.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import Foundation
import CoreLocation
import GoogleMaps

protocol BackCoordinates
{
    func setLocation(location: CLLocation)
    
}

class SetLocationViewController: UIViewController, CLLocationManagerDelegate
{
    @IBOutlet weak var mapView: GMSMapView!
    var locationManager = CLLocationManager()
    var myView = GMSMapView()
    var camera = GMSCameraPosition()
    var myLocation = CLLocation()
    var delegate : BackCoordinates?
    
    
    @IBAction func backButton(_ sender: Any)
    {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Add", bundle: nil)
        let initViewController: UIViewController = storyBoard.instantiateViewController(withIdentifier: "addId") as! AddItemViewController
        self.present(initViewController,animated: false, completion: nil)
    }
    
    override func viewDidLoad()
    {
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
   
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        self.showCurrentLocationOnMap()
        self.locationManager.stopUpdatingLocation()
    }
    
    func showCurrentLocationOnMap ()
    {
        let camera = GMSCameraPosition.camera(withLatitude: (self.locationManager.location?.coordinate.latitude)!, longitude: (self.locationManager.location?.coordinate.longitude)!, zoom: 14)
        let myView = GMSMapView.map(withFrame: CGRect(x : 0, y: 0, width: self.mapView.frame.size.width, height: self.mapView.frame.size.height), camera: camera)
        myView.settings.myLocationButton = true
        myView.isMyLocationEnabled = true
        
        let marker = GMSMarker()
        myLocation = CLLocation(latitude: camera.target.latitude, longitude: camera.target.longitude)
        delegate?.setLocation(location: myLocation)
        print("Мои координаты 1 - \(myLocation)")
        marker.snippet = "Current location"
        marker.appearAnimation = kGMSMarkerAnimationPop
        marker.map = myView
        self.mapView.addSubview(myView)
        
        
        AdressManager.getAdress(latitude: myLocation.coordinate.latitude, longitude: myLocation.coordinate.longitude, success: {_ in
            
            
            DispatchQueue.main.async
                {
                    print("lffs ljikb")
            }
        }, failure:{errorCode in
        })
    }
    
////    func adressName ()
////    {
////        AdressManager.getAdress(latitude: myLocation.coordinate.latitude, longitude: myLocation.coordinate.longitude, success: {_ in
////            self.adressName()
////            
////            DispatchQueue.main.async
////                {
////                    print("lffs ljikb")
////                }
////        }, failure:{errorCode in
////    })
//    }

}
