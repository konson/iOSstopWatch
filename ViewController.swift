//
//  ViewController.swift
//  Stop Watch
//
//  Created by Alecsandra Konson on 6/7/16.
//  Copyright © 2016 Apperator. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    var time = 0.0
    var timer = NSTimer()
    

    @IBOutlet var timeLabel: UILabel!
    

    @IBAction func pauseButton(sender: AnyObject) {
        timer.invalidate()
    }
    

    @IBAction func playButton(sender: AnyObject) {
        if !timer.valid {
            timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(ViewController.result), userInfo: nil, repeats: true)
        }
    }

    @IBAction func stopButton(sender: AnyObject) {
        timer.invalidate()
        time = 0.0
        formatTime()
    }
    
    func result() {
        time += 0.1
        formatTime()
    }
    
    
    func formatTime() {
        
        let hundreths = round((time % 1) * 100) // make hundreds a two-digit whole number
        
        timeLabel.text = String(format: " %02d:%02d:%02d:%02d ",
                             Int(time / 3600),          //hours
                             Int((time % 3600) / 60),   //minutes
                             Int((time % 3600) % 60),   //seconds
                             Int(hundreths))            //hundredths of second
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

