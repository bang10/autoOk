//
//  AttendanceView.swift
//  autoCheck
//
//  Created by 방성환 on 2023/09/24.
//

import SwiftUI

struct AttendanceView: View {
    private var attendanceService = AttendanceService()
    private var timeSet = TimeSet()
    @Binding private var studentId: String
    @State var lastAttendanceTime: String = ""
    @State var name: String = ""
    @State var department: String = ""
    @State var isCheckToStr: String = ""
    @State var subject: String = ""
    @State var studyTime: String = ""
    @State var attendaceTime: String = ""
    @State var isAttendance: String = ""
    @State var classroom: String = ""
    @State var grade: String = ""
    @State var subjectId: String? = ""
    
    init(studentId: Binding<String> = .constant("2018100249")) {
        _studentId = studentId
    }
    var body: some View {
        VStack {
            Form {
                HStack {
                    Spacer()
                    Text(lastAttendanceTime)
                    Spacer()
                }
                
                Section(content: {
                    if subject == "" {
                        Text("금일 출석할 강의가 없어요.")
                            .font(.system(size: 25))
                            .padding(.bottom, 15)
                    } else {
                        if isAttendance != "출석" {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color.red.opacity(0.5))
                                .frame(width: 330, height: 360)
                                .overlay(
                                    VStack (){
                                        if let subjectId = subjectId{
                                            Text(isCheckToStr)
                                                .font(.system(size: 25))
                                                .padding(.bottom, 15)
                                            VStack (alignment: .leading){
                                                Text("과목 : \(subject)")
                                                    .font(.system(size: 25))
                                                    .padding(.bottom, 15)
                                                Text("강의 시간 : \(studyTime)")
                                                    .font(.system(size: 25))
                                                    .padding(.bottom, 15)
                                                Text("출석 여부 : \(isAttendance)")
                                                    .font(.system(size: 25))
                                                    .padding(.bottom, 15)
                                                
                                                Text("강의실 : \(classroom)")
                                                    .font(.system(size: 25))
                                                    .padding(.bottom, 15)
                                            }
                                        } else {
                                            Text("출석 가능한 강의가 없습니다.")
                                        }
                                    }
                                        
                                )
                        } else {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color.blue.opacity(0.5))
                                .frame(width: 330, height: 360)
                                .overlay(
                                    VStack (){
                                        if let subjectId = subjectId{
                                            Text(isCheckToStr)
                                                .font(.system(size: 25))
                                                .padding(.bottom, 15)
                                            VStack (alignment: .leading){
                                                Text("과목 : \(subject)")
                                                    .font(.system(size: 25))
                                                    .padding(.bottom, 15)
                                                Text("강의 시간 : \(studyTime)")
                                                    .font(.system(size: 25))
                                                    .padding(.bottom, 15)
                                                Text("출석 시간 : \(attendaceTime)")
                                                    .font(.system(size: 25))
                                                    .padding(.bottom, 15)
                                                
                                                Text("출석 여부 : \(isAttendance)")
                                                    .font(.system(size: 25))
                                                    .padding(.bottom, 15)
                                                
                                                Text("강의실 : \(classroom)")
                                                    .font(.system(size: 25))
                                                    .padding(.bottom, 15)
                                            }
                                        } else {
                                            Text("이번시간에 출석할 강의가 없어요.")
                                        }
                                    }
                                        
                                )
                        }
                    }
                    
                })
                
                Text("이름 : \(name)")
                Text("학번 : \(studentId)")
                Text("학년 : \(grade)")
                Text("소속 : \(department)")
            }
        }
        .onAppear(perform: {
            attendanceService.getTodayStudnetAttendaceInfo(studentId: studentId) { res, error in
                if let res = res {
                    print(res)
                    subjectId = res.subjectId
                    subject = res.subjectName ?? ""
                    studyTime = res.scheduleTime ?? ""
                    isAttendance = res.attendance ?? "미출석"
                    classroom = res.classroom ?? ""
                    name = res.studentName
                    grade = res.grade
                    department = res.department
                    attendaceTime = res.attendanceTime ?? ""
                }
            }
            
            lastAttendanceTime = timeSet.getFormattedDate()
        })
        .navigationTitle("출석")
        .navigationBarTitleDisplayMode(.automatic)
        .refreshable {
            attendanceService.getTodayStudnetAttendaceInfo(studentId: studentId) { res, error in
                if let res = res {
                    print(res)
                    subjectId = res.subjectId
                    subject = res.subjectName ?? ""
                    studyTime = res.scheduleTime ?? ""
                    isAttendance = res.attendance ?? "미출석"
                    classroom = res.classroom ?? ""
                    name = res.studentName
                    grade = res.grade
                    department = res.department
                    attendaceTime = res.attendanceTime ?? ""
                }
            }
            
            lastAttendanceTime = timeSet.getFormattedDate()
        }
    }
    
}

#Preview {
    AttendanceView()
}
