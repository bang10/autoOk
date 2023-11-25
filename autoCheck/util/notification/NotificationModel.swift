//
//  NotificationModel.swift
//  autoCheck
//
//  Created by seonghwan on 11/26/23.
//

import Foundation
import UserNotifications


class NotificationModel {
    func pushNotification(title: String, body: String, seconds: Double, identifier: String) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title
        notificationContent.body = body
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: notificationContent, trigger: trigger)
//        HapticHelper.shared.impact(style: .medium)
        
        let conter = UNUserNotificationCenter.current()
        conter.add(request) { error in
            if let error = error {
                print("Notification error: \(error)")
            }
        }
        
    }

}
