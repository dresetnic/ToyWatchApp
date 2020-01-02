//
//  AccelerometerViewModel.swift
//  Record WatchKit Extension
//
//  Created by Dragos Resetnic on 02/01/2020.
//  Copyright © 2020 Dragos Resetnic. All rights reserved.
//

import Foundation
import CoreMotion

class Accelerometer {
    
    let motionManager: CMMotionManager
    
    var updateSettings: AccelerometerModel!
    
    var x: Double
    var y: Double
    var z: Double
    var lastX: Double
    var lastY: Double
    var lastZ: Double
    let kFilteringFactor = 0.1
    
    init(manager: CMMotionManager){
        
        motionManager = manager
        motionManager.accelerometerUpdateInterval = 1.0 / 60
        motionManager.startDeviceMotionUpdates()
        
        x = 0.0
        y = 0.0
        z = 0.0
        lastX = 0.0
        lastY = 0.0
        lastZ = 0.00
        getAccelerometerUpdates()
    }
    
    func getAccelerometerUpdates() {
        if motionManager.isAccelerometerAvailable {
            motionManager.startAccelerometerUpdates(to: OperationQueue.main) { (data, error) in
                if let acceleration = data {
                    
                    self.lowPassFilter(data: acceleration)
                    if self.lastX != self.x || self.lastY != self.y || self.lastZ != self.z{
                        self.updateSettings.x = String(format: "x: %.1f", self.x)
                        self.updateSettings.y = String(format: "y: %.1f", self.y)
                        self.updateSettings.z = String(format: "z: %.1f", self.z)
                        self.updateSettings.isMoving = true
                    } else {
                        self.updateSettings.isMoving = false
                    }
                } else {
                    
                }
            }
        } else {
            self.updateSettings.isMoving = false
        }
    }
    
    func lowPassFilter(data: CMAccelerometerData){
        self.lastX = self.x
        self.lastY = self.y
        self.lastZ = self.z
        
        self.x = ((data.acceleration.x * kFilteringFactor) + self.x * (1.0 - kFilteringFactor)).rounded(toPlaces: 3)
        self.y = ((data.acceleration.y * kFilteringFactor) + self.y * (1.0 - kFilteringFactor)).rounded(toPlaces: 3)
        self.z = ((data.acceleration.z * kFilteringFactor) + self.z * (1.0 - kFilteringFactor)).rounded(toPlaces: 3)
    }
}
