//
//  SpeedTest.swift
//  Website Time Loading
//
//  Created by Kevin on 01/10/2015.
//  Copyright © 2015 Pirade. All rights reserved.
//

import UIKit
import SafariServices

protocol SpeedDelegate {
    
    func finishedLoading(url:NSURL, loadingTime:NSTimeInterval)
    
}

class SpeedTest: SFSafariViewController, SFSafariViewControllerDelegate {
    
    var speedDelegate:SpeedDelegate?
    var url:NSURL!
    
    var timeStarted = NSDate()
    var timeEnded = NSDate()
    
    func safariViewController(controller: SFSafariViewController, didCompleteInitialLoad didLoadSuccessfully: Bool) {
        
        timeEnded = NSDate()
        let timeInterval = timeEnded.timeIntervalSinceDate(timeStarted)
        speedDelegate?.finishedLoading(url, loadingTime: timeInterval)
        
    }
    
    
    convenience init(URL: NSURL, speedDelegate:SpeedDelegate) {
        
        self.init(URL: URL, entersReaderIfAvailable: false)
        self.speedDelegate = speedDelegate
        
    }
    
    override  init(URL: NSURL, entersReaderIfAvailable: Bool) {
        
        timeStarted = NSDate()
        super.init(URL: URL, entersReaderIfAvailable: entersReaderIfAvailable)
        delegate = self
        url = URL
        title = url.host
        
    }
    
    deinit {
        
        speedDelegate = nil
    
    }
    
}