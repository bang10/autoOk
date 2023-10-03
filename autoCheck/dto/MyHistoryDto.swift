//
//  MyHistoryDto.swift
//  autoCheck
//
//  Created by seonghwan on 10/3/23.
//

import Foundation

struct MyHistoryDto: Codable {
    var studentId: String
    var subjectId: String
    var date: String
    var attendance: String
    var name: String
    var strCreatedAt: String
    var createdAt: String
}
