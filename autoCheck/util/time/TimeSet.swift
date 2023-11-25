//
//  TimeSet.swift
//  autoCheck
//
//  Created by seonghwan on 10/3/23.
//

import Foundation

class TimeSet {
    func getFormattedDate() -> String {
            let currentDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy/MM/dd"
            return dateFormatter.string(from: currentDate)
        }
    
    func formatTime(_ seconds: Int) -> String {
            let minutes = seconds / 60
            let seconds = seconds % 60
            return String(format: "%02d분 %02d초", minutes, seconds)
        }
    
    func getTimeTranceString(time: String) -> String {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        inputDateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let inputDate = inputDateFormatter.date(from: time) {
            var calendar = Calendar.current
            
            var dateComponents = DateComponents()
            dateComponents.hour = -9
            
            if let modifiedDate = calendar.date(byAdding: dateComponents, to: inputDate) {
                let outputDateFormatter = DateFormatter()
                outputDateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
            
                let outputDateString = outputDateFormatter.string(from: modifiedDate)
                return outputDateString
            } else {
                return "false"
            }
        } else {
            return "NaN"
        }
    }
    
}
