//
//  ViewController.swift
//  MusicVideo
//
//  Created by Erik Nascimento on 2/14/16.
//  Copyright © 2016 2EG. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var videos = [Videos]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector:"reachabilityStatusChanged", name:"ReachStatusChanged", object: nil)
        
        reachabilityStatusChanged()
        
        //Call API
        
        
       
    }
    
    func runAPI(){
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=50/json", completion: didLoadData)
    }
    
    func didLoadData(videos:[Videos]){
    
        self.videos = videos
        
        print(reachabilityStatus)
        
        for item in videos{
            print("Name = \(item.vName)")
        }
        
        for (index, item) in videos.enumerate(){
            print("\(index) Name = \(item.vName)")
        }
        
        tableView.reloadData()
    }
    
    func reachabilityStatusChanged(){
        switch reachabilityStatus{
        case NOACCESS:
            view.backgroundColor = UIColor.redColor()
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let alert = UIAlertController(title: "No Internet Access", message: "Please make sure you are connected to the Internet.", preferredStyle: .Alert)
                let cancelAction = UIAlertAction(title: "Cancel", style: .Default, handler: { (action) -> Void in
                    print("Cancel")
                })
                let deleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: { (action) -> Void in
                    print("Delete")
                })
                let okAction = UIAlertAction(title: "Ok", style: .Default, handler: { (action) -> Void in
                    print("Ok")
                })
                alert.addAction(okAction)
                alert.addAction(cancelAction)
                alert.addAction(deleteAction)
                
                self.presentViewController(alert, animated: true, completion: nil);
            })

            //displayLabel.text = "No Internet"
//        case WIFI:view.backgroundColor = UIColor.greenColor()
//            displayLabel.text = "Reachable with WIFI"
//        case WWAN:view.backgroundColor = UIColor.yellowColor()
//            displayLabel.text = "Reachable with Cellular"
        default:
            view.backgroundColor = UIColor.greenColor()
            if videos.count > 0{
                print("do not refresh API")
            }else{
                runAPI()
            }
        }
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }


    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        let video = videos[indexPath.row]
        
        cell.textLabel?.text = ("\(indexPath.row + 1)")
        cell.detailTextLabel?.text = video.vName
        
        return cell
    }

    

}

