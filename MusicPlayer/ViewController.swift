//
//  ViewController.swift
//  MusicPlayer
//
//  Created by Suebtas on 4/2/2558 BE.
//  Copyright (c) 2558 ist. All rights reserved.
//

//
//  ViewController.swift
//  MusicPlayer
//
//  Created by Suebtas on 4/2/2558 BE.
//  Copyright (c) 2558 ist. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, APIControllerProtocol   {
    @IBOutlet var appsTableView : UITableView?
    var tableData = []
    var api = APIController()
    // let session = NSURLSession.sharedSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        api.delegate = self
        api.searchItunesFor("Angry Birds")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MyTestCell")
        
        let rowData: NSDictionary = self.tableData[indexPath.row] as NSDictionary
        
        cell.textLabel?.text = rowData["trackName"] as? String
        
        // Grab the artworkUrl60 key to get an image URL for the app's thumbnail
        let urlString: NSString = rowData["artworkUrl60"] as NSString
        let imgURL: NSURL? = NSURL(string: urlString)
        
        // Download an NSData representation of the image at the URL
        let imgData = NSData(contentsOfURL: imgURL!)
        cell.imageView?.image = UIImage(data: imgData!)
        
        // Get the formatted price string for display in the subtitle
        let formattedPrice: NSString = rowData["formattedPrice"] as NSString
        
        cell.detailTextLabel?.text = formattedPrice
        
        return cell
    }
    
    func didReceiveAPIResults(results: NSDictionary) {
        var resultsArr: NSArray = results["results"] as NSArray
        dispatch_async(dispatch_get_main_queue(), {
            self.tableData = resultsArr
            self.appsTableView!.reloadData()
        })
    }
}


