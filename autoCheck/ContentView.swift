//
//  ContentView.swift
//  autoCheck
//
//  Created by 방성환 on 2023/09/21.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    @Binding private var studentId: String
    
    init(studentId: Binding<String> = .constant("")) {
        _studentId = studentId
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("\(studentId)의 출석")
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

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // 앱 실행 시 사용자에게 알림 허용 권한을 받음
        UNUserNotificationCenter.current().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
        )
        return true
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.list, .banner])
    }
}
