//
//  MasterViewController.swift
//  Step 4
//
//  Created by Ash Furrow on 2014-09-27.
//  Copyright (c) 2014 Ash Furrow. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    var objects: [[String: String]]?
    
    override func viewDidLoad() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refresh", forControlEvents: .ValueChanged)
        self.refreshControl = refreshControl
        self.refresh()
    }
    
    func refresh() {
        let resource = "http://static.ashfurrow.com/course/dinges.json"
        let url = NSURL(string: resource)
        let request = NSURLRequest(URL: url!)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            if let data = data {
                let json: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil)
                let photos: AnyObject! = (json as [String: AnyObject])["photos"]
                self.objects = photos as? [[String: String]]
            } else {
                println("Something went wrong: \(error)")
            }
            
            self.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        }
    }
    
    // Mark: - Table View stuff
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let objects = objects {
            return countElements(objects)
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        
        if let objects = objects {
            cell.textLabel?.text = objects[indexPath.row]["name"]
        }
        
        return cell;
    }
}

