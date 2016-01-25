//
//  InterfaceController.swift
//  policewatch5 WatchKit Extension
//
//  Created by Joseph Gao on 1/23/16.
//  Copyright © 2016 Joseph Gao. All rights reserved.
//

import WatchKit
import Foundation
import CoreMotion
import WatchConnectivity

class InterfaceController: WKInterfaceController {

    @IBOutlet var listenLabel: WKInterfaceLabel!
    @IBOutlet var xLabel: WKInterfaceLabel!
    @IBOutlet var yLabel: WKInterfaceLabel!
    @IBOutlet var zLabel: WKInterfaceLabel!
    
    
    var listening = false
    var currAccel = 0
    var session: WCSession? {
        didSet {
            if let session = session {
                session.delegate = self
                session.activateSession()
            }
        }
    }
    let motionManager = CMMotionManager()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        motionManager.accelerometerUpdateInterval = 0.1

    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func listenButton() {
        if (listening) {
            listening = false
            listenLabel.setText("Tap to Listen")
            stopAccel()
        }
        else {
            listening = true
            listenLabel.setText("Listening...")
            startAccel()
            // calculate 3d accel
            
                // if > threshold, tell iphone to get current location and make post request. 
        }
        
    }
    
    func startAccel() {
        print("Accel started")
        if motionManager.accelerometerAvailable {
            let handler:CMAccelerometerHandler = {(data: CMAccelerometerData?, error: NSError?) -> Void in
                self.xLabel.setText(String(format: "%.2f", data!.acceleration.x))
                self.yLabel.setText(String(format: "%.2f", data!.acceleration.y))
                self.zLabel.setText(String(format: "%.2f", data!.acceleration.z))
            }
            motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!, withHandler: handler)
            print("test")
        }
        else {
            xLabel.setText("not available")
            yLabel.setText("not available")
            zLabel.setText("not available")
        }
    }
    
    func stopAccel() {
        motionManager.stopAccelerometerUpdates()
        print("Accel stopped")
        xLabel.setText("x: 0")
        yLabel.setText("y: 0")
        zLabel.setText("z: 0")
    }
    
    func pingIphone() {
        session = WCSession.defaultSession()
        session!.sendMessage(
            ["hello": "joseph"],
            replyHandler: { (response) -> Void in
                // do nothing
            }, errorHandler: { (error) -> Void in
                print(error)
        })
    }
}
extension InterfaceController: WCSessionDelegate {
    
}
