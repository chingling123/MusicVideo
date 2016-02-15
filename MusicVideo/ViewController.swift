//
//  ViewController.swift
//  MusicVideo
//
//  Created by Erik Nascimento on 2/14/16.
//  Copyright © 2016 2EG. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector:"reachabilityStatusChanged", name:"ReachStatusChanged", object: nil)
        
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
    
    func reachabilityStatusChanged(){
        switch reachabilityStatus{
        case NOACCESS:view.backgroundColor = UIColor.redColor()
            displayLabel.text = "No Internet"
        case WIFI:view.backgroundColor = UIColor.greenColor()
            displayLabel.text = "Reachable with WIFI"
        case WWAN:view.backgroundColor = UIColor.yellowColor()
            displayLabel.text = "Reachable with Cellular"
        default:return
        }
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
    }

}

