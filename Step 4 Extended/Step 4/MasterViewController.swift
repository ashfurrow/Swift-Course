//
//  MasterViewController.swift
//  Step 4
//
//  Created by Ash Furrow on 2014-09-27.
//  Copyright (c) 2014 Ash Furrow. All rights reserved.
//

import UIKit

class Photo {
    let name: String = ""
    let photoURL: String = ""
    var image: UIImage? = nil
    
    init(name: String, photoURL: String) {
        self.name = name
        self.photoURL = photoURL
    }
    
    func downloadImage(completion: (photo: Photo) -> ()) {
        let url = NSURL(string: photoURL)
        let request = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            if let data = data {
                self.image = UIImage(data: data)
                completion(photo: self)
            }
        }
    }
}

class MasterViewController: UITableViewController {
    var photos: [Photo]?
    
    override func viewDidLoad() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refresh", forControlEvents: .ValueChanged)
        self.refreshControl = refreshControl
    }
    
    func refresh() {
        let resource = "http://static.ashfurrow.com/course/dinges.json"
        let url = NSURL(string: resource)
        let request = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            if let data = data {
                let json: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil)
                let photos: AnyObject! = (json as [String: AnyObject])["photos"]
                
                self.photos = (photos as? [[String: String]])?.map({ (photoDictionary: [String: String]) -> Photo in
                    return Photo(name: photoDictionary["name"]!, photoURL: photoDictionary["url"]!)
                })
            } else {
                println("Something went wrong: \(error)")
            }
            
            self.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        }
    }
    
    // Mark: - Table View stuff
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let photos = photos {
            return photos.count
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        
        if let photos = photos {
            let photo = photos[indexPath.row]
            cell.textLabel?.text = photo.name
            if let image = photo.image {
                cell.imageView?.image = photo.image
            } else {
                photo.downloadImage({ (photo) -> () in
                    tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                })
            }
        }
        
        return cell;
    }
}

