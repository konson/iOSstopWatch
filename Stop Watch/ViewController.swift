//
//  ViewController.swift
//  Stop Watch
//
//  Created by Alecsandra Konson on 6/7/16.
//  Copyright © 2016 Apperator. All rights reserved.
//


///////
/* NSTimer would not render the time to 1/100 sec quickly enough so my timer was too slow. Each second seemed to take about 1.5 seconds. Used CADisplayLink, bc animation-related timing. http://blog.agupieware.com/2014/08/tutorial-simple-ios-stopwatch-app-in.html
 */
////////


import UIKit
import Foundation
import QuartzCore

class ViewController: UIViewController {
    
    var displayLink: CADisplayLink!
    var lastDisplayLinkTimeStamp: CFTimeInterval!
    
    
    @IBOutlet var timeLabel: UILabel!
    
    @IBAction func pauseButton(sender: AnyObject) {
        displayLink.paused = true
    }
    
    
    @IBAction func playButton(sender: AnyObject) {
        if displayLink.paused == true { //if user pushes play while already playing do nothing
            displayLink.paused = false
        }
    }
    
    @IBAction func stopButton(sender: AnyObject) {
        
        
        // Pause display link updates //
        self.displayLink.paused = true;
        
        // Set default numeric display value //
        self.timeLabel.text = "00:00:00:00"
        
        // Reset our running tally //
        self.lastDisplayLinkTimeStamp = 0.0
        
        
    }

    func displayLinkUpdate(sender: CADisplayLink) {
        
        // Update running tally //
        self.lastDisplayLinkTimeStamp = self.lastDisplayLinkTimeStamp + self.displayLink.duration
        
        // Format the running tally to display on the last two significant digits //
            
            let hundreths = Int((lastDisplayLinkTimeStamp % 1) * 100) // make hundreds a two-digit whole number
            
            timeLabel.text = String(format: " %02d:%02d:%02d:%02d ",
                                    Int(lastDisplayLinkTimeStamp / 3600),          //hours
                Int((lastDisplayLinkTimeStamp % 3600) / 60),   //minutes
                Int((lastDisplayLinkTimeStamp % 3600) % 60),   //seconds
                Int(hundreths))            //hundredths of second
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Initializing the display link and directing it to call our displayLinkUpdate method when an update is available //
        self.displayLink = CADisplayLink(target: self, selector: #selector(ViewController.displayLinkUpdate(_:)))
        
        // Ensure that the display link is initially not updating //
        self.displayLink.paused = true;
        
        // Scheduling the Display Link to Send Notifications //
        self.displayLink.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
        
        // Initial timestamp //
        self.lastDisplayLinkTimeStamp = self.displayLink.timestamp
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
