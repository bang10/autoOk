//
//  AttendanceView.swift
//  autoCheck
//
//  Created by 방성환 on 2023/09/24.
//

import SwiftUI
import ActivityKit

struct AttendanceView: View {
    @Binding private var studentId: String
    private var attendanceStruct = AttendanceBeacon()
    private var attendanceService = AttendanceService()
    private var notification = NotificationModel()
    private var timeSet = TimeSet()
    private var alert = Alert()
    let attrbutes = dynamicIslandAttributes()
    let timeInterval = 1.0
    @State private var attendanceDate: [AttendanceInfoDto]?
    @State private var getTodayAttendaceInfo: TodayStudentAttendanceInfoDto? = nil
    @State private var SubjectAttendance: SubjectAttendance?
    @State private var isGetData: Bool = false
    @State private var isAttendance: Bool = false
    @State private var time = 0
    @State private var isEndActivity: Bool = false
    
    @State var activity: Activity<dynamicIslandAttributes>? = nil
    
    init(studentId: Binding<String> = .constant("2018100249")) {
        _studentId = studentId
    }
    var body: some View {
        ZStack {
            VStack {
                Form {
                    Section (content: {
                        HStack {
                            Spacer()
                            Text("\(timeSet.getFormattedDate())")
                            Spacer()
                        } // HStack
                    }) // Section
                    
                    // 데이터를 받아오는 중이라면
                    if !isGetData {
                        Section (content: {
                            HStack {
                                Spacer()
                                Text("출석 정보를 확인하고 받아오고 있어요.")
                                    .font(.system(size: 15))
                                Spacer()
                            } // HStack
                        }) // section
                    }
                    if !isAttendance {
                        Section (content: {
                            HStack {
                                Spacer()
                                Text("출석 처리를 하고 있어요.")
                                    .font(.system(size: 15))
                                Spacer()
                            } // HStack
                        }) // section
                    }
                    
                    // 출석화면
                    Section (content: {
                        if let getTodayAttendaceInfo = getTodayAttendaceInfo {
                            if let subjectId = getTodayAttendaceInfo.subjectId {
                                if getTodayAttendaceInfo.attendance == nil {
                                    if subjectId != ""{
                                        attendanceDesign(getTodayAttendaceInfo: getTodayAttendaceInfo)
                                    }
                                } else {
                                    if getTodayAttendaceInfo.attendance == "출석" {
                                        RoundedRectangle (cornerRadius: 10)
                                            .foregroundColor(Color.blue.opacity(0.5))
                                            .frame(width: 330, height: 300)
                                            .overlay (
                                                attendanceDesign(getTodayAttendaceInfo: getTodayAttendaceInfo)
                                            ) // overlay
                                    } else if getTodayAttendaceInfo.attendance == "지각" || getTodayAttendaceInfo.attendance == "결석"{
                                        RoundedRectangle (cornerRadius: 10)
                                            .foregroundColor(Color.red.opacity(0.5))
                                            .frame(width: 330, height: 300)
                                            .overlay (
                                                attendanceDesign(getTodayAttendaceInfo: getTodayAttendaceInfo)
                                            ) // overlay
                                    } else {
                                        HStack {
                                            Spacer()
                                            Text("출석 가능한 강의가 없어요.")
                                            Spacer()
                                        }
                                    }
                                }
                            } else {
                                HStack {
                                    Spacer()
                                    Text("출석 가능한 강의가 없어요.")
                                    Spacer()
                                }
                            }
                            
                        }
                    }) // section
                    
                    Section (content: {
                        if let getTodayAttendaceInfo = getTodayAttendaceInfo {
                            Text("학생명: \(getTodayAttendaceInfo.studentName)")
                            Text("학번: \(getTodayAttendaceInfo.studentId)")
                            Text("학년: \(getTodayAttendaceInfo.grade)")
                            Text("학과: \(getTodayAttendaceInfo.department)")
                        }
                    })
                    
                } // Form
            } // VStack
        } // ZStack
        .navigationTitle("\(studentId)의 출석")
        .refreshable {
            Task {
                do {
                    time = 0
                  try  await attendance()
                } catch {
                    alert.alert(message: "비인가 접근이 감지되었습니다.")
                }
            }
        }

        .onAppear(perform: {
            let state = dynamicIslandAttributes.ContentState(time: timeSet.formatTime(time/2), isAttendance: getTodayAttendaceInfo?.attendance ?? "출석중", subjectName: getTodayAttendaceInfo?.subjectName ?? "", classroom: getTodayAttendaceInfo?.classroom ?? "")
                activity = try? Activity<dynamicIslandAttributes>.request(attributes: attrbutes, contentState: state)
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                Task {
                    do {
                        try await attendance()
                    } catch {
                        alert.alert(message: "비인가 접근이 감지되었습니다.")
                    }
                }
                time += 1
                if isEndActivity {
                    timer.invalidate()
                }
            }
        })
    } // Body: View
    
    func getTodayStudyInfo() async throws{
        do {
            let res = try await attendanceService.getTodayStudnetAttendaceInfo(studentId: studentId)
                getTodayAttendaceInfo = res
            isGetData = true
        } catch {
            print("\(error)")
        }
        
    } // func
    
    func attendance() {
        Task {
            do {
                try await getTodayStudyInfo()
                if let getTodayAttendaceInfo = getTodayAttendaceInfo {
                    if let subjectId = getTodayAttendaceInfo.subjectId {
                        if subjectId != "" {
                            if let attendance = getTodayAttendaceInfo.attendance {
                                isAttendance = true
                            } // attendance Unlapping
                            else {
                                attendanceStruct.detectBeacon(ssAaDto: SSAADto(subjectId: getTodayAttendaceInfo.subjectId ?? "", studentId: self.studentId, studyTime: getTodayAttendaceInfo.scheduleTime ?? "", isAttendance: getTodayAttendaceInfo.attendance ?? "")) { res in
                                    if let res = res {
                                        if res {
                                            alert.alert(message: "출석에 성공했어요.")
                                            notification.pushNotification(title: "출석 안내", body: "출석 처리가 완료되었습니다.", seconds: 1, identifier: "PUSH_TEST")
                                            HapticHelper.shared.impact(style: .medium)
                                            Task {
                                                do {
                                                    try await getTodayStudyInfo()
                                                } catch {
                                                    print("error")
                                                }
                                            }
                                            isAttendance = true
                                        }
                                    }
                                }
                            }
                        } // subjectId check isEmpty
                    } // subjectId Unlapping
                    Task {
                        let state = dynamicIslandAttributes.ContentState(time: timeSet.formatTime(time/2), isAttendance: getTodayAttendaceInfo.attendance ?? getTodayAttendaceInfo.attendance ?? "출석중", subjectName: getTodayAttendaceInfo.subjectName ?? "", classroom: getTodayAttendaceInfo.classroom ?? "")
                        await activity?.update(using: state)
                    }
                    if let subjectId = getTodayAttendaceInfo.subjectId {
                        print(subjectId)
                        print(getTodayAttendaceInfo)
                        if subjectId != "", (getTodayAttendaceInfo.attendance != nil) {
                            isEndActivity = await StopActivity.shared.stop(acticivy: activity!)
                        }
                    }
                    
                } // getTodayAttendance
            } catch {
                print("error")
            }
        }
        isAttendance = true
    }

} // struct

#Preview {
    AttendanceView()
}
