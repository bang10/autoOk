//
//  AttendanceView.swift
//  autoCheck
//
//  Created by 방성환 on 2023/09/24.
//

import SwiftUI
import BackgroundTasks

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
    @State private var remainingTime: TimeInterval = 180.0 // 3분
    @State private var timer: Timer?
    @State var resc: String = ""
    @State private var isServerRequesting = false
    
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

                Text(resc)
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
                                            Text(String(format: "남은 시간 : %.0f초", remainingTime))
                                                            .font(.largeTitle)
                                                            .padding()
                                                        
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
                                            Text(String(format: "남은 시간 : %.0f초", remainingTime))
                                                            .font(.largeTitle)
                                                            .padding()
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
            getTodayStudyInfo()
            attedanceAction()
            resetTimer()
            startTimer()
            
        })
        .navigationTitle("출석")
        .navigationBarTitleDisplayMode(.automatic)
        .refreshable {
            resetTimer()
            attedanceAction()
            startTimer()
        }
    }
    
    func getTodayStudyInfo() {
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
            }
        }
        
        lastAttendanceTime = timeSet.getFormattedDate()
        attedanceAction()
    
    }
    func attedanceAction() {
        resc = "start attendance ation"
        if subject != "", isAttendance != "출석" {
            if connectionBeacon.beaconDetected {
                attendanceService.saveAttendance(param: SSAADto(subjectId: subjectId ?? "", studentId: studentId, studyTime: studyTime)) { res, error in
                    if let res = res {
                        subject = res.subjectName ?? ""
                        isAttendance = res.attendance ?? ""
                        stopTimer()
                        alert.alert(message: "출석을 성공적으로 처리했어요.")
                    }
                }
            }
        }
    }
    
    func startTimer() {
        resc = "start timer"
            // 이미 타이머가 실행 중이면 중단
            timer?.invalidate()
            
            // 1초마다 실행되는 타이머 설정
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                if self.remainingTime > 0 {
                    self.remainingTime -= 1.0
                    if !isServerRequesting {
//                        attedanceAction()
                    }
                } else {
                    // 타이머가 종료되면 중단
                    timer.invalidate()
                }
            }
        }
        
        // 타이머를 3분으로 리셋
        func resetTimer() {
            remainingTime = 180.0
            timer?.invalidate()
        }
        
        // 백그라운드 태스크 등록
        func registerBackgroundTask() {
            BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.example.backgroundtask", using: nil) { task in
                // 백그라운드 태스크가 실행될 때 특정 코드를 실행
                self.performBackgroundTask()
                task.setTaskCompleted(success: true)
            }
        }
        
        // 백그라운드 태스크에서 실행할 특정 코드
        func performBackgroundTask() {
            // 백그라운드에서 실행할 코드를 여기에 작성
            // 예를 들어 네트워킹 또는 데이터 동기화 작업 등을 수행할 수 있습니다.
        }
    
    // 타이머 중지
        func stopTimer() {
            timer?.invalidate()
            timer = nil
        }
    
}

#Preview {
    AttendanceView()
}
