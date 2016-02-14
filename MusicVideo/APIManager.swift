//
//  APIManager.swift
//  MusicVideo
//
//  Created by Erik Nascimento on 2/14/16.
//  Copyright © 2016 2EG. All rights reserved.
//

import Foundation

class APIManager {
    
    func loadData(urlString:String, completion:(result:String) -> Void){
        
        //DISABLE CACHE
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        
        let session = NSURLSession(configuration: config)
        
//        let session = NSURLSession.sharedSession()
        
        let url = NSURL(string: urlString)
        
        let task = session.dataTaskWithURL(url!) { (data, response, error) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if error != nil{
                    completion(result: (error!.localizedDescription))
                }else{
                    completion(result: "NSURLSession successfull")
                    print(data)
                }

            })
        }
        
        task.resume()
        
    }
    
}