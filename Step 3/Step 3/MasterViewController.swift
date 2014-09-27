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
        return countElements(greetings)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        
        cell.textLabel?.text = greetings[indexPath.row]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        println("Did select greeting: \(greetings[indexPath.row])")
    }
}

