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
