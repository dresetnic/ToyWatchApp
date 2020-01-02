//
//  DeviceModel.swift
//  Record WatchKit Extension
//
//  Created by Dragos Resetnic on 02/01/2020.
//  Copyright © 2020 Dragos Resetnic. All rights reserved.
//

import Foundation

struct Device: Identifiable{
    let id: UUID
    public let name: String
    public let rssi: NSNumber
}
