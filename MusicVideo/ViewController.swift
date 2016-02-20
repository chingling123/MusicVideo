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
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"preferredFontChange", name:UIContentSizeCategoryDidChangeNotification, object: nil)
        
        reachabilityStatusChanged()
        
    }
    
    func preferredFontChange(){
        print("The preferred Font has changed")
    }
    
    func runAPI(){
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=200/json", completion: didLoadData)
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
        default:
            if videos.count > 0{
                print("do not refresh API")
            }else{
                runAPI()
            }
        }
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }


    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    private struct storyboard{
        static let cellReuseIdentifier = "cell"
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(storyboard.cellReuseIdentifier, forIndexPath: indexPath) as! MusicVideoTableViewCell
        
        cell.video = videos[indexPath.row]
        
        return cell
    }

}

