//
//  attendanceDesign.swift
//  autoCheck
//
//  Created by seonghwan on 11/25/23.
//

import SwiftUI

struct attendanceDesign: View {
    private var getTodayAttendaceInfo: TodayStudentAttendanceInfoDto
    
    init(getTodayAttendaceInfo: TodayStudentAttendanceInfoDto) {
        self.getTodayAttendaceInfo = getTodayAttendaceInfo
    }
    
    var body: some View {
        VStack (alignment: .leading){
            if let res = getTodayAttendaceInfo.subjectName {
                Text("과목명: \(res)")
                    .font(.system(size: 25))
                    .padding(.bottom, 15)
            }
            if let res = getTodayAttendaceInfo.scheduleTime {
                Text ("강의시간: \(res)")
                    .font(.system(size: 25))
                    .padding(.bottom, 15)
            }
            if let res = getTodayAttendaceInfo.attendanceTime {
                Text("출석시간: \(res)")
                    .font(.system(size: 25))
                    .padding(.bottom, 15)
            }
            if let res = getTodayAttendaceInfo.attendance {
                Text("출석: \(res)")
                    .font(.system(size: 25))
                    .padding(.bottom, 15)
            }
            if let res = getTodayAttendaceInfo.classroom {
                Text("강의실: \(res)")
                    .font(.system(size: 25))
            }
        } // VStack
        
    }
}

#Preview {
    attendanceDesign(getTodayAttendaceInfo: TodayStudentAttendanceInfoDto(grade: "", studentName: "", studentId: "", department: "", departmentId: ""))
}
