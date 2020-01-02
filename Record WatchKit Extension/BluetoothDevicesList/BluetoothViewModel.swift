//
//  BluetoothViewModel.swift
//  Record WatchKit Extension
//
//  Created by Dragos Resetnic on 02/01/2020.
//  Copyright © 2020 Dragos Resetnic. All rights reserved.
//

import SwiftUI
import CoreBluetooth
import Combine

class BluetoothViewModel: NSObject, ObservableObject{
    
    let RSSI_range = -50..<(-10)  // optimal -22dB
    
    var centralManager: CBCentralManager!
    var discoveredPeripheral: CBPeripheral?
    
    let objectWillChange = ObservableObjectPublisher()
    
    var isConnected: Bool = false
    
    var selectedDevice:Device? = nil{
        didSet{
            if let peripheral = items[selectedDevice!.name] {
                centralManager.connect(peripheral, options: nil)
            }
        }
    }
    
    @Published var dataSource: [Device] = []
    
    var items: [String: CBPeripheral] = [:]
    
    override init(){
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func scan() {
        centralManager.scanForPeripherals(withServices: nil, options: nil)
    }
}

extension BluetoothViewModel: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn: scan()
        case .poweredOff, .resetting: return
        default: return
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        // guard RSSI_range.contains(RSSI.intValue) && discoveredPeripheral != peripheral else { return } //RSSI Range filter
                
        if let name = peripheral.name{
            
            if self.items[name] == nil {
                self.items[name] = peripheral
                let device = Device(id: UUID.init(), name: name, rssi: RSSI)
                self.dataSource.append(device)
                objectWillChange.send()
            }
        }
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("🟠 Failed to connect to:\(String(describing: peripheral.name))")
        
        if let error = error { print(error.localizedDescription) }
        isConnected = false
        objectWillChange.send()
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("🔵 Connected to:\(String(describing: peripheral.name))")
        central.stopScan()
        isConnected = true
        objectWillChange.send()
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("🔴 Disconnected from:\(String(describing: peripheral.name))")
        scan()
        isConnected = false
        objectWillChange.send()
    }
}
