//
//  APIManager.swift
//  MusicVideo
//
//  Created by Erik Nascimento on 2/14/16.
//  Copyright © 2016 2EG. All rights reserved.
//

import Foundation

class APIManager {
    
    func loadData(urlString:String, completion:[Videos] -> Void){
        
        //DISABLE CACHE
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        
        let session = NSURLSession(configuration: config)
        
//        let session = NSURLSession.sharedSession()
        
        let url = NSURL(string: urlString)
        
        let task = session.dataTaskWithURL(url!) { (data, response, error) -> Void in
            if error != nil{
                print(error!.localizedDescription)
            }else{
                
                do{
                    if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? JSONDictionary,
                        feed = json["feed"] as? JSONDictionary, entries = feed["entry"] as? JSONArray{
                            
                            var videos = [Videos]()
                            
                            for (index, entry) in entries.enumerate(){
                                let entry = Videos(data: entry as! JSONDictionary)
                                entry.vRank = index + 1
                                videos.append(entry)
                            }
                            
                            
                            let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                            dispatch_async(dispatch_get_global_queue(priority, 0), { () -> Void in
                                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                    completion(videos)
                                })
                            })
                    }
                }catch{
                        print("error in NSJSONSerialization")
                }

            }
            
        }
        
        task.resume()
        
    }
    
}