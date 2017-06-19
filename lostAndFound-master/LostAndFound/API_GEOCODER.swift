//
//  API_GEOCODER.swift
//  LostAndFound
//
//  Created by Орлов Максим on 19.05.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import Foundation
import GoogleMaps
import GooglePlaces
import SwiftyJSON

class API_GEOCODER : API_WRAPPER
{
    class func getAdress ( latitude : CLLocationDegrees, longitude : CLLocationDegrees , success : @escaping (JSON) -> Void , failure : @escaping (Int) -> Void) -> URLSessionDataTask
    {
        let urlString = "https://maps.googleapis.com/maps/api/geocode/json?latlng=\(latitude),\(longitude)&language=ru&key=AIzaSyBVCSRWUlvAdb197sEG-zo05w2dq_HfF1U"
        
        let url = URL(string: urlString)!
        // url - user readable link
        let request = URLRequest(url: url)

        print("zapros skontruirovan")
        print(url)
        let task = URLSession.shared.dataTask(with: request, completionHandler: {data , response, error in
            
            
            self.genericCompletionCallback(data: data, response: response, error: error, success: success, failure: failure)
            
        })
        
        task.resume()
        print("zapros ushel")
        
        return task
    }
    
    class func getLocation( adress : GMSPlace, success : @escaping (JSON) -> Void , failure : @escaping (Int) -> Void) -> URLSessionDataTask
    {
        let formattedAdress = adress.formattedAddress!
        let myStringArr = formattedAdress.components(separatedBy: " ")
        let location = myStringArr.joined(separator: "+")
        
        let urlString = "https://maps.googleapis.com/maps/api/geocode/json?address=\(location)&key=AIzaSyBVCSRWUlvAdb197sEG-zo05w2dq_HfF1U"
        
        let url = URL(string: urlString)!
        // url - user readable link
        let request = URLRequest(url: url)
        
        print("zapros skontruirovan")
        print(url)
        let task = URLSession.shared.dataTask(with: request, completionHandler: {data , response, error in
            
            
            self.genericCompletionCallback(data: data, response: response, error: error, success: success, failure: failure)
            
        })
        
        task.resume()
        print("zapros ushel")
        
        return task
    }
}
