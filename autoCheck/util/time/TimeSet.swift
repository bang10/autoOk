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
    
    func getTimeTranceString(time: String) -> String {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"

        if let inputDate = inputDateFormatter.date(from: time) {
            let outputDateString = outputDateFormatter.string(from: inputDate)
            return outputDateString
        } else {
            return "NaN"
        }

    }
}
