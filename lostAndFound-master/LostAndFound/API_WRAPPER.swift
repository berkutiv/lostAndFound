//
//  API_WRAPPER.swift
//  LostAndFound
//
//  Created by Иван on 26.04.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import Foundation
import SwiftyJSON

class API_WRAPPER
{
    class func getUsers (id: String, success : @escaping (User) -> Void , failure : @escaping (Int) -> Void) -> URLSessionDataTask
    {
        let urlString = "https://api.vk.com/method/newsfeed.get?count=10&start_from=&access_token=&filter=posts&v=5.63"
        
        let url = URL(string: urlString)!
        // url - user readable link
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler:
            {data , response, error in
                
                //self.genericCompletionCallback(data: data, response: response, error: error, success: success, failure: failure)
                
        })
        
        let array = UsersFactory.generateData()
        for i in 0..<array.count
        {
            if (array[i] as! User).id == id
            {
                success((array[i] as! User))
            }
        }
        
        
        task.resume()
        return task
    }
    
}
//меняю возвращаемое значение саксесс блока на МАССИВ!
extension API_WRAPPER
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
                //print(json)
                success(json)
                return
            }
            catch
            {
                failure(-1)
                return
            }
        }
        
        
        failure(-1)
    }
   
}
