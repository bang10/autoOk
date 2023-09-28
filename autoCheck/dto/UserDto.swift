//
//  LoginDto.swift
//  autoCheck
//
//  Created by 방성환 on 2023/09/25.
//

import Foundation

struct LoginDto: Codable {
    var studentId: String
    var password: String
}

struct FindStudentDto: Codable {
    var studentName: String
    var tellNumber: String
}

struct FindStudentInfoDto: Encodable {
    var studentName: String
    var studentId: String
    var tellNumber: String
}

struct UpdatePasswordDto: Codable {
    var studentId: String
    var newPassword: String
}

struct joinDto: Codable {
    var studentId: String
    var name: String
    var tellNumber: String
    var birth: String
    var grade: String
}
