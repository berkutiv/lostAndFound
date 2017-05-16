//
//  ViewController.swift
//  LostAndFound
//
//  Created by Иван on 11.04.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MapViewController: UIViewController
{
    var dataSource = NSMutableArray()
    
    @IBOutlet weak var blackView: UIView!
    var tableView : MapTableView?
    var map : GMSMapView?
    var tableViewCell : ItemTableViewCell?
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var mapView: GMSMapView!
    var placesClient: GMSPlacesClient!
    var zoomLevel: Float = 15.0
    
    var likelyPlaces: [GMSPlace] = []
    var selectedPlace: GMSPlace?
    let defaultLocation = CLLocation(latitude: -33.869405, longitude: 151.199)

    override func viewDidLoad()
    {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        placesClient = GMSPlacesClient.shared()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        if map == nil
        {
            let camera = GMSCameraPosition.camera(withLatitude: defaultLocation.coordinate.latitude,
                                                  longitude: defaultLocation.coordinate.longitude,
                                                  zoom: zoomLevel)
            mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
            mapView.settings.myLocationButton = true
            mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            mapView.isMyLocationEnabled = true
            map = mapView
            
            // Creates a marker in the center of the map.
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: 55.45, longitude: 37.36)
            marker.title = "moscow"
            marker.snippet = "Russia"
            marker.map = mapView
            
            dataSource = ModelsFactory.generateModels() as! NSMutableArray
            
            for i in 0..<dataSource.count
            {
                let item = dataSource[i] as! Item
                let position = CLLocationCoordinate2D(latitude: Double(item.latitude)!, longitude: Double(item.longitude)!)
                let marker = GMSMarker(position: position)
                marker.title = "\(item.title)"
                marker.map = mapView
            }
            
            map!.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - 144 )

            view.addSubview(map!)
            blackView.backgroundColor = UIColor.black
            blackView.alpha = 0
            
            view.addSubview(blackView)
        
            listLikelyPlaces()
        }
        
        
        if tableView == nil
        {
            tableView = Bundle.main.loadNibNamed("MapTableView", owner: self, options: nil)![0] as? MapTableView
            tableView?.frame = CGRect(x: 0, y: view.frame.size.height - 144, width: view.frame.width, height: view.frame.height)
            tableView?.blockWithCoordinates = {[weak self] (longtitude, latitude) in
                self?.locateMarker(longitude: longtitude, latitude: latitude)
                self?.blackView.alpha = 0
            }
            tableView?.blockWithAlpha = {[weak self] (float) in
                //print("высота \(self?.view.frame.height)")
                let alpha = float/(self?.view.frame.height)!*0.8
                self?.blackView.alpha = 1 - alpha
                print("alpha \(self?.blackView.alpha)")
            }
            tableView?.pushBlock = {[weak self] (model) in
                let storyBoard = UIStoryboard(name: "Add", bundle: nil)
                let itemViewController = storyBoard.instantiateViewController(withIdentifier: "itemViewController") as! ItemViewController
                
                itemViewController.id = "\(model.id)"
                self?.present(itemViewController, animated: true, completion: nil)
            }

           
            
            view.addSubview(tableView!)
        }
        super.viewWillAppear(animated)
    }

    @IBAction func unwindToMain(segue: UIStoryboardSegue)
    {
        // Clear the map.
        mapView.clear()
        
        // Add a marker to the map.
        if selectedPlace != nil {
            let marker = GMSMarker(position: (self.selectedPlace?.coordinate)!)
            marker.title = selectedPlace?.name
            marker.snippet = selectedPlace?.formattedAddress
            marker.map = mapView
        }
        
        listLikelyPlaces()
    }
    
    func listLikelyPlaces() {
        // Clean up from previous sessions.
        likelyPlaces.removeAll()
        
        placesClient.currentPlace(callback: { (placeLikelihoods, error) -> Void in
            if let error = error {
                // TODO: Handle the error.
                print("Current Place error: \(error.localizedDescription)")
                return
            }
            
            // Get likely places and add to the list.
            if let likelihoodList = placeLikelihoods {
                for likelihood in likelihoodList.likelihoods {
                    let place = likelihood.place
                    self.likelyPlaces.append(place)
                }
            }
        })
    }
    
//    // Prepare the segue.
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == &quot;segueToSelect&quot; {
//            if let nextViewController = segue.destination as? PlacesViewController {
//                nextViewController.likelyPlaces = likelyPlaces
//            }
//        }
//    }
}

extension MapViewController: CLLocationManagerDelegate {
    
     //Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        print("Location: \(location)")
        
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: zoomLevel)
        
        if mapView.isHidden {
            mapView.isHidden = false
            mapView.camera = camera
        } else {
            mapView.animate(to: camera)
        }
        
        listLikelyPlaces()
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
}

//MARK: - локейт маркер
extension MapViewController
{
    public func locateMarker(longitude: String, latitude: String)
    {
        print("long \(longitude) lat \(latitude)")
        let camera = GMSCameraPosition.camera(withLatitude: Double(latitude)!,
                                              longitude: Double(longitude)!,
                                              zoom: 350.0)
        
        if mapView.isHidden {
            mapView.isHidden = false
            mapView.camera = camera
        } else {
            mapView.animate(to: camera)
        }

    }
}

