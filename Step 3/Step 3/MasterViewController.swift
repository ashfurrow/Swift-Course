//
//  MasterViewController.swift
//  Step 3
//
//  Created by Ash Furrow on 2014-09-27.
//  Copyright (c) 2014 Ash Furrow. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    var greetings = ["Hello", "Goedemorgen", "Bon matin", "Buenos días", "Guten morgen", "Buongiorno", "おはよう"]
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return greetings.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("Cell") {
            cell.textLabel?.text = greetings[indexPath.row]
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        print("Did select greeting: \(greetings[indexPath.row])")
    }
}

