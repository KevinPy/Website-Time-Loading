//
//  List.swift
//  Website Time Loading
//
//  Created by Kevin on 01/10/2015.
//  Copyright © 2015 Pirade. All rights reserved.
//

import UIKit
import SafariServices

class List: UITableViewController, SpeedDelegate {

    let sites = SiteList.sites
    let contentBlockingEnabled = true
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.setRightBarButtonItem(UIBarButtonItem(title: "Infos", style: .Plain, target: self, action: "infos"), animated: true)
        
        print("Website URL, Time", contentBlockingEnabled ? "Optimized\n" : "Standard\n")
        
    }
    
    func infos() {
        
        let infos = UIAlertController(title: "Created by Pirade", message: "Check the Xcode console to see the total time to load.", preferredStyle: .Alert)
        
        let visit = UIAlertAction(title: "Visit Pirade Website", style: .Default, handler: {(action) -> Void in
            
            let url = NSURL(string: "http://pirade.net")!
            UIApplication.sharedApplication().openURL(url)
            
        })
        
        let ok = UIAlertAction(title: "OK", style: .Cancel, handler: {(action) -> Void in})
        
        infos.addAction(visit)
        infos.addAction(ok)
        self.presentViewController(infos, animated: true, completion: nil)
        
    }
    
    func finishedLoading(url: NSURL, loadingTime: NSTimeInterval) {
        
        print("\(url), \(loadingTime)")
        
        if let splitViewController = self.splitViewController{

            if splitViewController.collapsed {
                self.navigationController?.popViewControllerAnimated(true)
                delay(1.0) {
                    self.loadNext()
                }
            } else {
                delay(1.0) {
                    self.loadNext()
                }
            }
            
        }
        
    }
    
    func loadNext() {
        
        let currentIndex = tableView.indexPathForSelectedRow?.row ?? 0
        let nextIndex = currentIndex + 1
        
        if nextIndex < sites.count {
            
            let nextPath = NSIndexPath(forRow: nextIndex, inSection: 0)
            title = "\(nextIndex + 1) / \(sites.count)"
            tableView.selectRowAtIndexPath(nextPath, animated: true, scrollPosition: .Middle)
            performSegueWithIdentifier("showDetail", sender: nil)
            
        } else {
            
            title = "Completed"
            
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.clearsSelectionOnViewWillAppear = false
        super.viewWillAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showDetail", let indexPath = self.tableView.indexPathForSelectedRow {
            
            let object = sites[indexPath.row]
            let destinationNav = segue.destinationViewController as! UINavigationController
            let safari = SpeedTest(URL: NSURL(string: "http://" + object)!, speedDelegate:self)
            destinationNav.setViewControllers([safari], animated: false)
            
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sites.count
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let object = sites[indexPath.row]
        cell.textLabel?.text = object
        return cell
        
    }
  
}

public func delay(delay:Double, closure:()->()) {
    
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
    
}