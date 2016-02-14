//
//  ViewController.swift
//  MusicVideo
//
//  Created by Erik Nascimento on 2/14/16.
//  Copyright © 2016 2EG. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Call API
        
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", completion: didLoadData)
    }
    
    func didLoadData(videos:[Videos]){
    
        print(reachabilityStatus)
        
        for item in videos{
            print("Name = \(item.vName)")
        }
        
        for (index, item) in videos.enumerate(){
            print("\(index) Name = \(item.vName)")
        }
    }

}

