//
//  RecordDto.swift
//  autoCheck
//
//  Created by 방성환 on 2023/09/24.
//

import Foundation

struct Record: Codable, Hashable{
    var subject: String?
    var attendance: String?
    var time: String?
}

struct RecordParamDto: Codable, Hashable {
    var subjectId: String
    var strCreatedAt: String
    var attendance: String
}

struct GetHistoryDto: Codable, Hashable {
    var attendance: String
    var createdAt: String
    var name: String
}

struct  TodayStudentAttendanceInfoDto: Codable {
    var subjectName: String?
    var subjectId: String?
    var scheduleTime: String?
    var scheduleDay: String?
    var attendanceAbsenceId: String?
    var attendance: String?
    var classroom: String?
    var grade: String
    var studentName: String
    var studentId:  String
    var department: String
    var departmentId: String
    var studentSubjectId: String?
    var attendanceTime: String?
}

struct SubjectBasicInfoDto: Codable, Hashable {
    var subjectId: String
    var name: String
}

struct AttendanceInfoDto:Codable, Hashable {
    var attendanceAbsenceId: String
    var attendance: String
}

struct SSAADto: Codable {
    var subjectId: String
    var studentId: String
    var studyTime: String
}
