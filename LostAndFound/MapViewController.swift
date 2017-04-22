//
//  ViewController.swift
//  LostAndFound
//
//  Created by Иван on 11.04.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController
{
    var tableView : MapTableView?
    var map : GMSMapView?
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("ПРИВЕТ МАКС")
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        if map == nil
        {
            let camera = GMSCameraPosition.camera(withLatitude: 55.45, longitude: 37.36, zoom: 6.0)
            let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
            mapView.isMyLocationEnabled = true
            map = mapView
            
            // Creates a marker in the center of the map.
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: 55.45, longitude: 37.36)
            marker.title = "moscow"
            marker.snippet = "Russia"
            marker.map = mapView
            
            map!.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - 144 )

            view.addSubview(map!)
        }
        
        
        if tableView == nil
        {
            tableView = Bundle.main.loadNibNamed("MapTableView", owner: self, options: nil)![0] as? MapTableView
            tableView?.frame = CGRect(x: 0, y: view.frame.size.height - 144, width: view.frame.width, height: view.frame.height)
            view.addSubview(tableView!)
        }
        super.viewWillAppear(animated)
    }


}

