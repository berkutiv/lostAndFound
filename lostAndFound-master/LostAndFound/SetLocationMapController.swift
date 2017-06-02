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
import GooglePlaces

protocol BackCoordinates
{
    func setLocation(adress : String)
}

class SetLocationViewController: UIViewController, CLLocationManagerDelegate
{
    @IBOutlet weak var mapView: GMSMapView!
    var locationManager = CLLocationManager()
    var myView = GMSMapView()
    var camera = GMSCameraPosition()
    var myLocation = CLLocation()
    var delegate : BackCoordinates?
    var adress = String()
    var resultsViewController : GMSAutocompleteResultsViewController?
    var searchController : UISearchController?
    var resultsView : UITextView?
    
    @IBAction func backButton(_ sender: Any)
    {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Add", bundle: nil)
        let initViewController: UIViewController = storyBoard.instantiateViewController(withIdentifier: "addId") as! AddItemViewController
        self.present(initViewController,animated: false, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad()
        
    {
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
        
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        
        searchController?.searchBar.sizeToFit()
        navigationItem.titleView = searchController?.searchBar
        
        definesPresentationContext = true
        
        searchController?.hidesNavigationBarDuringPresentation = false
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
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
        
        print("Мои координаты 1 - \(myLocation)")
        marker.snippet = "Current location"
        marker.appearAnimation = kGMSMarkerAnimationPop
        marker.map = myView
        self.mapView.addSubview(myView)
        
        SetLocationManager.getAdress(latitude: myLocation.coordinate.latitude, longitude: myLocation.coordinate.longitude, success: {
            [weak self] (currentadress) in
            
            
            DispatchQueue.main.async
                {
                    self?.adress = currentadress
                    self?.delegate?.setLocation(adress: currentadress)
                    
            }
            }, failure:{errorCode in
        })
    }
    
}

extension SetLocationViewController : GMSAutocompleteResultsViewControllerDelegate
{
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace)
    {
        searchController?.isActive = false
        // Do something with the selected place.
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress)")
        print("Place attributions: \(place.attributions)")
        
        
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didFailAutocompleteWithError error: Error){
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController)
    {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController)
    {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}

