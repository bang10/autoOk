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
}
