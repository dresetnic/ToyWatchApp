//
//  Double+Extension.swift
//  Record WatchKit Extension
//
//  Created by Dragos Resetnic on 02/01/2020.
//  Copyright © 2020 Dragos Resetnic. All rights reserved.
//

import Foundation

extension Double {
        func rounded(toPlaces places:Int) -> Double {
            let divisor = pow(10.0, Double(places))
            return (self * divisor).rounded() / divisor
        }
}
