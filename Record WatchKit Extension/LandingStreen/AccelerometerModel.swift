//
//  AccelerometerModel.swift
//  Record WatchKit Extension
//
//  Created by Dragos Resetnic on 02/01/2020.
//  Copyright © 2020 Dragos Resetnic. All rights reserved.
//

import SwiftUI

class AccelerometerModel: ObservableObject {
    @Published var x: String = "x:"
    @Published var y: String = "y:"
    @Published var z: String = "z:"
    @Published var isMoving: Bool = false
}
