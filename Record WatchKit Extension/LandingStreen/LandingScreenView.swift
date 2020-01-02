//
//  ContentView.swift
//  Record WatchKit Extension
//
//  Created by Dragos Resetnic on 30/12/2019.
//  Copyright © 2019 Dragos Resetnic. All rights reserved.
//

import SwiftUI

struct LandingScreenView: View {
    
    @ObservedObject var settings: AccelerometerModel
    @ObservedObject var viewModel: BluetoothViewModel
    @State private var show_modal: Bool = false
    
    var body: some View {
        VStack{
            HStack{
                Text(settings.x)
                Text(settings.y)
                Text(settings.z)
            }
            HStack{
                Ellipse()
                    .fill(settings.isMoving ? Color.green : Color.red)
                    .frame(width: 50, height: 50)
                Button(action: {
                    self.show_modal = true
                }){
                    Rectangle().fill(viewModel.isConnected ? Color.blue: Color.yellow)
                        .frame(width: 50, height: 50).background(Color.black)
                }.sheet(isPresented: self.$show_modal) {
                    BluetoothDevicesView(viewModel: self.viewModel)
                }
            }
        }
    }
}
