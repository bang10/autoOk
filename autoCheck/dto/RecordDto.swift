//
//  RecordDto.swift
//  autoCheck
//
//  Created by 방성환 on 2023/09/24.
//

import Foundation

struct Record: Codable, Hashable{
    var subject: String
    var attendance: String
    var time: String
}

struct  TodayStudentAttendanceInfoDto: Codable, Hashable {
    var subjectName: String
    var subjectId: String
    var scheduleTime: String
    var scheduleDay: String
    var attendanceAbsenceId: String
    var classroom: String
    var grade: String
    var studentName: String
    var studentId:  String
    var department: String
    var departmentId: String
    var studentSubjectId: String
}
