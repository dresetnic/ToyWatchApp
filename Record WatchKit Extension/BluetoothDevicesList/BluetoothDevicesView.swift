//
//  BluetoothList.swift
//  Record WatchKit Extension
//
//  Created by Dragos Resetnic on 02/01/2020.
//  Copyright © 2020 Dragos Resetnic. All rights reserved.
//

import SwiftUI

struct BluetoothDevicesView: View {
    
    @ObservedObject var viewModel: BluetoothViewModel
    @Environment(\.presentationMode) var presentationMode
    
    init(viewModel: BluetoothViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        return GeometryReader { geometry in
            List {
                if self.viewModel.dataSource.isEmpty {
                    self.emptySection
                } else {
                    self.imagesSection(geometry: geometry)
                }
            }
            .listStyle(PlainListStyle())
        }
    }
    
    func dismiss() {
        self.presentationMode.wrappedValue.dismiss()
    }
}

private extension BluetoothDevicesView {
    var emptySection: some View {
        Section {
            Text("Searching...")
                .foregroundColor(.red)
        }
    }
    
    func imagesSection(geometry: GeometryProxy) -> some View {
        Section {
            ForEach(viewModel.dataSource){ model in
                HStack{
                    Button(action: {
                        self.viewModel.selectedDevice = model
                        self.dismiss()}) {Text("\(model.name)")}
                }
            }
        }
    }
}

struct BluetoothList_Previews: PreviewProvider {
    static var previews: some View {
        let model = BluetoothViewModel()
        return BluetoothDevicesView(viewModel: model)
    }
}



