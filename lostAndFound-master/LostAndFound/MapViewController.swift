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
import FirebaseAuth

class MapViewController: UIViewController
{
    var dataSource = NSMutableArray()


    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var tableView: UITableView!
    var map : GMSMapView?
    var tableViewCell : ItemTableViewCell?
    var headerView: UIView?
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var mapView: GMSMapView!
    var placesClient: GMSPlacesClient!
    var zoomLevel: Float = 15.0
    
    var likelyPlaces: [GMSPlace] = []
    var selectedPlace: GMSPlace?
    let defaultLocation = CLLocation(latitude: 35, longitude: 35)
    
    let kItemTableNIB = UINib(nibName: "ItemTableViewCell", bundle: nil)
    let kItemTableViewCellReuseIdentifier = "kItemTableViewCellReuseIdentifier"
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        FIRAuth.auth()?.currentUser?.refreshToken
        
        let userId : String = UserDefaults.standard.value(forKey: "uid") as! String // - АЙДИ
        let userToken : String = UserDefaults.standard.value(forKey: "utoken") as! String // - ТОКЕН
        
        print("token - \(MapViewController.token)")
        print(userId)
        print(userToken)
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        placesClient = GMSPlacesClient.shared()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedSectionHeaderHeight = 50
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        tableView.register(kItemTableNIB, forCellReuseIdentifier: kItemTableViewCellReuseIdentifier)
        
        dataSource = ModelsFactory.generateModels() as! NSMutableArray
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        //Настройки навигационника
        navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.black
        let backButton = UIBarButtonItem(title: "Назад", style:.plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButton
    
        if map == nil
        {
            let camera = GMSCameraPosition.camera(withLatitude: defaultLocation.coordinate.latitude,
                                                  longitude: defaultLocation.coordinate.longitude,
                                                  zoom: zoomLevel)
            mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
            mapView.settings.myLocationButton = true
            mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            mapView.isMyLocationEnabled = true
            mapView.delegate = self
            map = mapView
            
            // Creates a marker in the center of the map.
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: 35, longitude: 37.36)
            marker.title = "moscow"
            marker.snippet = "Russia"
            marker.map = mapView
            
            dataSource = ModelsFactory.generateModels() as! NSMutableArray
            
            for i in 0..<dataSource.count
            {
                let item = dataSource[i] as! Item
                let position = CLLocationCoordinate2D(latitude: Double(item.latitude)!, longitude: Double(item.longitude)!)
                let marker = GMSMarker(position: position)
                
                let pinImage = UIImage(named: "placeholder3")
                let markerView = UIImageView(image: pinImage)
                let pinPhoto = UIImageView(frame: CGRect(x: 6.5, y: 3, width: 27, height: 27))
                pinPhoto.image = UIImage(named: "\((dataSource[i] as! Item).photosURL[0])")
                pinPhoto.layer.cornerRadius = pinPhoto.frame.width/2
                pinPhoto.layer.masksToBounds = true
                markerView.addSubview(pinPhoto)
                marker.iconView = markerView
                marker.title = "\(item.id)"
                
                marker.map = mapView
            
            }
            
            map!.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - 144 )
            
            view.insertSubview(map!, belowSubview: blackView)
            blackView.backgroundColor = UIColor.black
            blackView.alpha = 0
            view.insertSubview(blackView, at: 1)
            
            listLikelyPlaces()
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
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    {
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
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
}


extension MapViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let model = dataSource[indexPath.row] as! Item
        let cell = tableView.dequeueReusableCell(withIdentifier: kItemTableViewCellReuseIdentifier, for: indexPath) as! ItemTableViewCell
        cell.configureSelf(model: model)
        cell.coordinatesBlock = {[weak self] (longtitude, latitude) in
            self?.locateMarker(longitude: longtitude, latitude: latitude)
            self?.hideTable()
            tableView.isScrollEnabled = false
            var indexPath = IndexPath(item: 0, section: 0)
            tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let model = dataSource[indexPath.row] as! Item
        let storyBoard = UIStoryboard(name: "Item", bundle: nil)
        let itemViewController = storyBoard.instantiateViewController(withIdentifier: "ItemViewController") as! ItemViewController
        
        itemViewController.id = "\((model).id)"
        
        navigationController?.pushViewController(itemViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        if self.headerView != nil
        {
            return self.headerView
        }
        
        let headerView = Bundle.main.loadNibNamed("tableViewHeader", owner: nil, options: nil)?[0] as! tableViewHeader
        self.headerView = headerView
        
        return headerView
    }
}

//MARK: - анимация таблицы
extension MapViewController
{
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        let currentOffset = scrollView.contentOffset.y
        
        print("offset \(currentOffset) origin y \(tableView.frame.origin.y) height \(tableView.frame.size.height)")
        if tableView.frame.origin.y > 0
        {
            if currentOffset > 0
            {
                tableView.frame.size.height += currentOffset
                tableView.frame.origin.y -= currentOffset
                let alpha = tableView.frame.origin.y/(self.view.frame.height)*0.8
                blackView.alpha = 1 - alpha
                if tableView.frame.origin.y < 400
                {
                    showTable()
                }
                
            }
        }
        
        if tableView.frame.origin.y == self.view.frame.height - 144
        {
            tableView.bounces = false
        }
        else
        {
            tableView.bounces = true
        }
        
        if currentOffset < 0 && tableView.frame.size.height > 144
        {
            tableView.frame.size.height += currentOffset
            tableView.frame.origin.y -= currentOffset
            if tableView.frame.origin.y > 20
            {
                hideTable()
            }
        } 
    }
    
    func hideTable()
    {
        UIView.animate(withDuration: 1)
        {
            self.tableView.frame.origin.y = self.view.frame.height - 144
            self.blackView.alpha = 0
        }
        
    }
    
    func showTable()
    {
        UIView.animate(withDuration: 1)
        {
            self.tableView.frame.origin.y = 0
            self.tableView.frame.size.height = self.view.frame.height
        }
    }
}

//MARK: - локейт маркер
extension MapViewController
{
    public func locateMarker(longitude: String, latitude: String)
    {
        //print("long \(longitude) lat \(latitude)")
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

extension MapViewController: GMSMapViewDelegate
{
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool
    {
        let storyBoard = UIStoryboard(name: "Item", bundle: nil)
        let itemViewController = storyBoard.instantiateViewController(withIdentifier: "ItemViewController") as! ItemViewController
        
        itemViewController.id = "\(marker.title)"
        self.navigationController?.pushViewController(itemViewController, animated: false)
        return true
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker)
    {
        print("нажали на окно")
    }
}
