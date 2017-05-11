//
//  API_GeoCoder.swift
//  LostAndFound
//
//  Created by Орлов Максим on 05.05.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import Foundation
import GoogleMaps
import SwiftyJSON

class API_GeoCoder
{
    class func getAdress ( latitude : CLLocationDegrees, longitude : CLLocationDegrees , success : @escaping (JSON) -> Void , failure : @escaping (Int) -> Void)
    {   
        let urlString = "https://maps.googleapis.com/maps/api/geocode/json?latlng=\(latitude),\(longitude)&key=AIzaSyBVCSRWUlvAdb197sEG-zo05w2dq_HfF1U"
        
        
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
    }
}


//MARK: -обработчик ответов из интернета
extension API_GeoCoder
{
    class func genericCompletionCallback (
        data : Data? ,
        response : URLResponse? ,
        error : Error? ,
        success : (JSON) -> Void ,
        failure : (Int) -> Void
        )
    {
        if (error != nil)
        {
            failure( (error as! NSError).code )
            return
        }
        if let rawData = data
        {
            do
            {
                let rawJSON = try JSONSerialization.jsonObject(with: rawData, options: JSONSerialization.ReadingOptions.mutableContainers)
                
                let json = JSON( rawJSON)
                print(json)
                success(json)
                return
            }
            catch
            {
                print ("pasing ne udalsia")
                failure(-1)
                
                return
            }
            
        }
        failure(-1)
        
    }
}



