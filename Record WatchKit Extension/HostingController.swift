//
//  HostingController.swift
//  Record WatchKit Extension
//
//  Created by Dragos Resetnic on 30/12/2019.
//  Copyright © 2019 Dragos Resetnic. All rights reserved.
//

import WatchKit
import Foundation
import SwiftUI
import CoreMotion
import CoreBluetooth

class HostingController: WKHostingController<LandingScreenView> {
    
    var accelerometerViewModel = AccelerometerModel()
    var bluetoothViewModel = BluetoothViewModel()
    
    lazy var motionManager: CMMotionManager = {
        let manager = CMMotionManager()
        manager.accelerometerUpdateInterval = 0.1
        return manager
    }()
    
    lazy var accelerometer:Accelerometer = {
        let accelerometer = Accelerometer(manager: self.motionManager)
        return accelerometer
    }()
    
    override var body: LandingScreenView {
        return LandingScreenView(settings: self.accelerometerViewModel, viewModel: self.bluetoothViewModel)
    }
    
    override func willActivate() {
        super.willActivate()
        accelerometer.updateSettings = self.accelerometerViewModel
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
}
