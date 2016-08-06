//
//  MasterViewController.swift
//  StormViewer
//
//  Created by My Nguyen on 8/4/16.
//  Copyright © 2016 My Nguyen. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // file manager
        let fm = NSFileManager.defaultManager()
        // resource path of the directory containing all assets (images)
        let path = NSBundle.mainBundle().resourcePath!
        // all the filenames in the resource path
        let items = try! fm.contentsOfDirectoryAtPath(path)
        // store the resource filenames that begin with "nssl" into objects
        for item in items {
            if item.hasPrefix("nssl") {
                objects.append(item)
            }
        }
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            // get the selected row
            if let indexPath = self.tableView.indexPathForSelectedRow {
                // cast the destinationViewController of the segue to a UINavigationController
                let navigationController = segue.destinationViewController as! UINavigationController
                // cast the topViewController of the navigationController to a DetailViewController
                let controller = navigationController.topViewController as! DetailViewController
                // extract the filename at the selected row; recall that objects is an array of String
                let object = objects[indexPath.row]
                // save the image filename in the detailViewController; similar to passing an extra to an Activity or Fragment in Android
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let object = objects[indexPath.row]
        cell.textLabel!.text = object
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
}

