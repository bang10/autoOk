//
//  AttendanceView.swift
//  autoCheck
//
//  Created by 방성환 on 2023/09/24.
//

import SwiftUI

struct AttendanceView: View {
    @EnvironmentObject var connectionBeacon: ConnectBeacon
    private var attendanceService = AttendanceService()
    private var timeSet = TimeSet()
    private var alert = Alert()
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
    @State var isGetData: Bool = false
    
    init(studentId: Binding<String> = .constant("2018100249")) {
        _studentId = studentId
    }
    var body: some View {
        VStack {
            if isGetData {
                Form {
                    HStack {
                        Spacer()
                        Text(lastAttendanceTime)
                        Spacer()
                    }
                    
                    Section(content: {
                        if subject == "" {
                            Text("이번시간에 출석할 강의가 없어요.")
                                .font(.system(size: 20))
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
            } else {
                Image(systemName: "square.stack.3d.up")
                    .font(.system(size: 30))
                    .transition(AnyTransition.opacity.animation(.easeInOut))
                    
                Text("데이터를 가져오고 있고, 출석 처리를 하고 있어요.")
                    .padding(.top, 5)
            }
            
        }
        .onAppear(perform: {
            Task {
                await getTodayStudyInfo()
            }
        })
        .navigationTitle("출석")
        .navigationBarTitleDisplayMode(.automatic)
        .refreshable {
            self.isGetData = false
            Task {
                await getTodayStudyInfo()
            }

        }
        
    }
    
    func getTodayStudyInfo() async {
        attendanceService.getTodayStudnetAttendaceInfo(studentId: studentId) { res, error in
            if let res = res {
                subjectId = res.subjectId
                subject = res.subjectName ?? ""
                studyTime = res.scheduleTime ?? ""
                isAttendance = res.attendance ?? ""
                classroom = res.classroom ?? ""
                name = res.studentName
                grade = res.grade
                department = res.department
                attendaceTime = res.attendanceTime ?? ""
                
                if isAttendance == "" {
                        if connectionBeacon.beaconDetected {
                            attendanceService.saveAttendance(param: SSAADto(subjectId: subjectId ?? "", studentId: studentId, studyTime: studyTime)) { res, error in
                                if let res =  res {
                                    self.isGetData = true
                                    subject = res.subjectName ?? ""
                                    isAttendance = res.attendance ?? ""
                                    Task {
                                     await getTodayStudyInfo()
                                    }
                                    
                                    self.isGetData = true
                                    alert.alert(message: "성공적으로 출석을 했어요.")
                                } else {
                                    self.isGetData = true
                                    alert.alert(message: "출석을 실패했어요.")
                                }
                            }
                        } else {
                            self.isGetData = true
                            alert.alert(message: "비콘을 인식하지 못했어요. 새로고침 해주세요.")
                        }
                    
                }
                self.isGetData = true
                
            }
        
        }
        
        lastAttendanceTime = timeSet.getFormattedDate()
    }
    
}
//
//#Preview {
//    AttendanceView()
//}
