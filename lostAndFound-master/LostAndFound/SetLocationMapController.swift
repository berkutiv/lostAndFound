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


class SetLocationViewController: UIViewController, CLLocationManagerDelegate
{
    @IBOutlet weak var mapView: GMSMapView!
    var locationManager = CLLocationManager()
    var didFindMyLocation = false
    var marker = GMSMarker()
    
    @IBAction func backButton(_ sender: Any)
    {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Add", bundle: nil)

        let initViewController: UIViewController = storyBoard.instantiateViewController(withIdentifier: "addId") as! AddItemViewController
        
        self.present(initViewController,animated: false, completion: nil)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        mapView.delegate = self as? GMSMapViewDelegate
        
        let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: 48.857165, longitude: 2.354613, zoom: 8.0)
        mapView.camera = camera
  
        mapView.addObserver(self, forKeyPath: "myLocation", options: NSKeyValueObservingOptions.new, context: nil)
        
        locationManager.delegate = self
        mapView.isMyLocationEnabled = true
        
        locationManager.requestWhenInUseAuthorization()
        
      
    }
    
    deinit {
        mapView.removeObserver(self, forKeyPath: "myLocation")
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?)
    {
        let myLocation : CLLocation = change![NSKeyValueChangeKey.newKey] as! CLLocation
        mapView.camera = GMSCameraPosition(target: myLocation.coordinate, zoom: 10.0, bearing: 0, viewingAngle: 0)
        mapView.settings.myLocationButton = true
        
        didFindMyLocation = true
    }
    
    func mapView(mapViewUIView: GMSMapView!, didTapAtCoordinate coordinate: CLLocationCoordinate2D)
    {
   
        
        print("You tap at - \(coordinate.latitude)")
    }
    
}


