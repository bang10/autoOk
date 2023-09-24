//
//  ContentView.swift
//  autoCheck
//
//  Created by 방성환 on 2023/09/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var connectionBeacon: ConnectBeacon
    
    @Binding private var studentId: String
    
    init(studentId: Binding<String> = .constant("studentId")) {
        _studentId = studentId
    }
    
    var body: some View {
        NavigationView {
            VStack {
                //            if connectionBeacon.beaconDetected {
                //                Text("Connected Beacon")
                //            } else {
                //                Text("Fail Connected Beacon")
                //            }
                //        }
                //        .padding()
            }
        }
        .navigationTitle("출석")
        .navigationBarTitleDisplayMode(.automatic)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
