//
//  MasterViewController.swift
//  Step 4
//
//  Created by Ash Furrow on 2014-09-27.
//  Copyright (c) 2014 Ash Furrow. All rights reserved.
//

import UIKit

class Photo {
    let name: String
    let photoURL: String
    var image: UIImage? = nil
    
    init(name: String, photoURL: String) {
        self.name = name
        self.photoURL = photoURL
    }
    
    func downloadImage(_ completion: @escaping (_ photo: Photo) -> ()) {
        let url = URL(string: photoURL)
        let request = URLRequest(url: url!)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) -> Void in
            if let data = data {
                self.image = UIImage(data: data)
                completion(self)
            }
        }
    }
}

class MasterViewController: UITableViewController {
    var photos: [Photo]?
    
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
                
                self.photos = (photos as? [[String: String]])?.map({ (photoDictionary: [String: String]) -> Photo in
                    return Photo(name: photoDictionary["name"]!, photoURL: photoDictionary["url"]!)
                })
            } else {
                print("Something went wrong: \(error)")
            }
            
            self.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        }
    }
    
    // Mark: - Table View stuff
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let photos = photos {
            return photos.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") {
            if let photos = photos {
                let photo = photos[indexPath.row]
                cell.textLabel?.text = photo.name
                if let image = photo.image {
                    cell.imageView?.image = image
                } else {
                    photo.downloadImage({ (photo) -> () in
                        tableView.reloadRows(at: [indexPath], with: .automatic)
                    })
                }
            }
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

