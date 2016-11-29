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
        refreshControl.addTarget(self, action: #selector(MasterViewController.refresh), for: .valueChanged)
        self.refreshControl = refreshControl
        self.refresh()
    }
    
    func refresh() {
        let resource = "http://static.ashfurrow.com/course/dinges.json"
        let url = URL(string: resource)
        let request = URLRequest(url: url!)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) -> Void in
            if let data = data {
                let json: AnyObject! = try? JSONSerialization.jsonObject(with: data, options: []) as AnyObject!
                let photos: AnyObject! = (json as! [String: AnyObject])["photos"]
                self.objects = photos as? [[String: String]]
            } else {
                print("Something went wrong: \(error)")
            }
            
            self.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        }
    }
    
    // Mark: - Table View stuff
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let objects = objects {
            return objects.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") {
            if let objects = objects {
                cell.textLabel?.text = objects[indexPath.row]["name"]
            }
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
