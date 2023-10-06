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
            return String(format: "%02d:%02d", minutes, seconds)
        }
    
    func getTimeTranceString(time: String) -> String {
        
        // 입력 형식을 정의
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        inputDateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        // 입력 문자열을 Date로 변환
        if let inputDate = inputDateFormatter.date(from: time) {
            // Calendar 객체 생성
            var calendar = Calendar.current
            
            // 날짜 계산을 위한 DateComponents 생성
            var dateComponents = DateComponents()
            dateComponents.hour = -9 // 9시간을 빼려면 음수로 설정
            
            // 9시간을 뺀 새로운 Date 계산
            if let modifiedDate = calendar.date(byAdding: dateComponents, to: inputDate) {
                // 출력 형식을 정의
                let outputDateFormatter = DateFormatter()
                outputDateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
                
                // 새로운 Date를 출력 형식의 문자열로 변환
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
