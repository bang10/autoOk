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
                Text("출석 체크")
                TabView {
                    AttendanceView(studentId: $studentId)
                        .padding(.bottom, 10)
                        .tabItem {
                            Image(systemName: "graduationcap.fill")
                                .font(.system(size: 30))
                                .background(.white)
                                .foregroundColor(.black)
                        }
                    
                    MyRecordView(studentId: $studentId)
                        .padding(.bottom, 10)
                        .tabItem {
                            Image(systemName: "menubar.dock.rectangle.badge.record")
                                .font(.system(size: 30))
                                .background(.white)
                                .foregroundColor(.black)
                        }
                }
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
