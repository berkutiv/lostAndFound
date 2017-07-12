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
    class func getUserItems (user: User, userId : String, success : @escaping (JSON) -> Void , failure : @escaping (Int) -> Void) -> URLSessionDataTask
    {
        
        let urlString = "https://us-central1-lostandfound-69075.cloudfunctions.net/getUserPosts?id=\(userId)"
        
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
        //меняю возвращаемое значение саксесс блока на МАССИВ!
    }
    
//МЕТОДЫ API
    
    // Создает пользователя по Элпочте и паролю
    class func createUserWithEmail ( email : String, nameUser : String, password : String, passwordRepeat : String, success : @escaping (JSON) -> Void , failure : @escaping (Int) -> Void) -> URLSessionDataTask
    {
        
        let urlString = "https://us-central1-lostandfound-69075.cloudfunctions.net/createUserWithEmail?email=\(email)&password=\(password)&passwordrepeat=\(passwordRepeat)&nameuser=\(nameUser)"
        
        //URL ENCODE
        let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)
        
        //URL DECODE - НУЖНО ПРИХУЯЧИТЬ ПРИ ОБРАНОМ ВЫЗОВЕ !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        // url - user readable link
        let request = URLRequest(url: url!)
        
        
        print("zapros skontruirovan")
        print(url)
        let task = URLSession.shared.dataTask(with: request, completionHandler: {data , response, error in
            
            
            self.genericCompletionCallback(data: data, response: response, error: error, success: success, failure: failure)
            
        })
        
        task.resume()
        print("zapros ushel")
        
        return task
    }
    //Авторизует пользователя по электронной почте и паролю
    
    class func AuthUserWithEmail ( email : String, password : String, success : @escaping (JSON) -> Void , failure : @escaping (Int) -> Void) -> URLSessionDataTask
    {
        
        let urlString = "https://us-central1-lostandfound-69075.cloudfunctions.net/authUserWithEmail?email=\(email)&password=\(password)"
        
       
        //URL ENCODE
        let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)
        
        //URL DECODE - НУЖНО ПРИХУЯЧИТЬ ПРИ ОБРАНОМ ВЫЗОВЕ !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        let request = URLRequest(url: url!)
        
        print("zapros skontruirovan")
        print(url)
        let task = URLSession.shared.dataTask(with: request, completionHandler: {data , response, error in
            
            
            self.genericCompletionCallback(data: data, response: response, error: error, success: success, failure: failure)
            
        })
        
        task.resume()
        print("zapros ushel")
        
        return task
    }
    
    //Получение вещи по ее ID
    
    class func getPost ( itemID : String, success : @escaping (JSON) -> Void , failure : @escaping (Int) -> Void) -> URLSessionDataTask
    {
        let urlString = "https://us-central1-lostandfound-69075.cloudfunctions.net/getPost?id=\(itemID)"
        
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

    //Получить информацию по пользователю по айди (имя, эл почта, фото (будет позже))
    
    class func getUser ( userId : String, success : @escaping (JSON) -> Void , failure : @escaping (Int) -> Void) -> URLSessionDataTask
    {
        let urlString = "https://us-central1-lostandfound-69075.cloudfunctions.net/getUser?id=\(userId)"
        
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
    
    //Добавляет пост со следующими полями (поля токен и айди обязательные)
    class func addPost (token : String,userId : String, itemName : String, itemDescription : String, itemLatitude : String, itemLongitude : String, itemAdress : String, itemReward : String, photos : NSArray, success : @escaping (JSON) -> Void , failure : @escaping (Int) -> Void) -> URLSessionDataTask
    {
        
       // let url = NSURL(string : s.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)
        
        let urlString = "https://us-central1-lostandfound-69075.cloudfunctions.net/addPost"//?token=\(token)&iduser=\(userId)&itemname=\(itemName)&itemdescription=\(itemDescription)&itemlatitude=\(itemLatitude)&itemlongitude=\(itemLongitude)&itemadress=\(itemAdress)&itemreward=\(itemReward)"
        
        //URL ENCODE
        let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)
        
        let bodyDictionary = NSMutableDictionary()
        
        bodyDictionary.setObject(token, forKey: "token" as NSString)
        bodyDictionary.setObject(userId, forKey: "iduser" as NSString)
        bodyDictionary.setObject(itemName, forKey: "itemname" as NSString)
        bodyDictionary.setObject(itemDescription, forKey: "itemdescription" as NSString)
        bodyDictionary.setObject(itemLongitude, forKey: "itemlongitude" as NSString)
        bodyDictionary.setObject(itemLatitude, forKey: "itemlatitude" as NSString)
        bodyDictionary.setObject(itemAdress, forKey: "itemadress" as NSString)
        bodyDictionary.setObject(itemReward, forKey: "itemreward" as NSString)
        bodyDictionary.setObject(photos, forKey: "photos" as NSString)

        let body = try? JSONSerialization.data(withJSONObject: bodyDictionary, options: JSONSerialization.WritingOptions(rawValue: 0))
        //URL DECODE - НУЖНО ПРИХУЯЧИТЬ ПРИ ОБРАНОМ ВЫЗОВЕ !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

        //let url = URL(string: urlString.stringByRemovingPercentEncoding)
        
        
        // url - user readable link
        let request = NSMutableURLRequest(url: url!)
        request.httpBody = body
        request.httpMethod = "POST"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        print("zapros skontruirovan")
        print(url)
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {data , response, error in
            
            
            self.genericCompletionCallback(data: data, response: response, error: error, success: success, failure: failure)
            
        })
        
        task.resume()
        print("zapros ushel")
        
        return task
    }
    
    //Возвращает последние ДЕСЯТЬ постов 
    
    class func getPosts (success : @escaping (JSON) -> Void , failure : @escaping (Int) -> Void) -> URLSessionDataTask
    {
        
        let urlString = "https://us-central1-lostandfound-69075.cloudfunctions.net/getWallPosts"
        
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
