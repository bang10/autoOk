//
//  ContentView.swift
//  autoCheck
//
//  Created by 방성환 on 2023/09/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var connectionBeacon: ConnectBeacon
    var body: some View {
        VStack {
            if connectionBeacon.beaconDetected {
                Text("Connected Beacon")
            } else {
                Text("Fail Connected Beacon")
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
