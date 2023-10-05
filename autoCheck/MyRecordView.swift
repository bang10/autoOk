//
//  MyRecordView.swift
//  autoCheck
//
//  Created by 방성환 on 2023/09/24.
//

import SwiftUI

struct MyRecordView: View {
    private var timeSet = TimeSet()
    private var myRecordService = MyRecordService()
    private var attendanceService = AttendanceService()
    private var validityController = ValidityController()
    private var alert = Alert()
    @Binding private var studentId: String
    @State var subjectList: [SubjectBasicInfoDto] = [
        SubjectBasicInfoDto(subjectId: "", name: "")
    ]
    @State var selectedSubject: SubjectBasicInfoDto = SubjectBasicInfoDto(subjectId: "", name: "")
    @State var time: String = ""
    @State var attendanceList: [AttendanceInfoDto] = [
        AttendanceInfoDto(attendanceAbsenceId: "", attendance: "")
    ]
    @State var selectAttendance: AttendanceInfoDto = AttendanceInfoDto(attendanceAbsenceId: "", attendance: "")
    @State var recordList: [GetHistoryDto] = [
        GetHistoryDto(attendance: "", createdAt: "", name: "")
    ]
    
    init(studentId: Binding<String> = .constant("2018100249")) {
        _studentId = studentId
    }
    var body: some View {
        VStack {
            Form{
                Section(header: Text("선택된 강의 : \(selectedSubject.name)\n선택된 출석여부 : \(selectAttendance.attendance)"),
                        content: {
                    HStack {
                        Picker("강의명", selection: $selectedSubject) {
                            ForEach(subjectList, id: \.self) { index in
                                Text(index.name)
                            }
                        }
                    }
                    
                    HStack {
                        Picker("출석 여부", selection: $selectAttendance) {
                            ForEach(attendanceList, id: \.self) { index in
                                Text(index.attendance)
                            }
                        }
                    }
                    HStack {
                        TextField("검색 년도를 입력해 주세요.(20231001)",text: $time)
                    }
                    HStack {
                        Spacer()
                        Button("검색"){
                            if validityController.validateDate(time: time) || time == "" {
                                getDate()
                            } else {
                                time = ""
                                alert.alert(message: "시간 형식을 지켜주세요.")
                            }
                        }
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        Button("초기화") {
                            selectedSubject = SubjectBasicInfoDto(subjectId: "", name: "")
                            selectAttendance = AttendanceInfoDto(attendanceAbsenceId: "", attendance: "")
                        }
                        Spacer()
                    }
                    
                    
                })

                
                Section(content: {
                    HStack {
                        Text("과목")
                            .frame(width: 50, alignment: .leading)
                        Spacer()
                        Text("출석결과")
                            .frame(width: 60)
                        Spacer()
                        Spacer()
                        Text("시간")
                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .leading)
                    }

                    List(recordList, id: \.self) { record in
                        HStack {
                            Text(record.name)
                                .font(.system(size: 13))
                                .frame(width: 50, alignment: .leading)
                            Spacer()
                            Text(record.attendance)
                                .frame(width: 60)
                            Spacer()
                            Text(timeSet.getTimeTranceString(time: record.createdAt))
                                .frame(width: 140)
                        }
                    }
                })
            }
            .onAppear(perform: {
                getDate()
                getSubjectBasicInfo()
                getAttendanceInfoList()
            })
        }
        .navigationTitle("출석")
        .navigationBarTitleDisplayMode(.automatic)

    }
    
    func getDate() {
        myRecordService.getMyHistoryList(studentId: studentId,historyDto: RecordParamDto(subjectId: selectedSubject.subjectId, strCreatedAt: time, attendance: selectAttendance.attendanceAbsenceId)) { res, err in
            if let res = res {
                DispatchQueue.main.async {
                    recordList = res
                }
            }
        }
    }
    
    func getSubjectBasicInfo() {
        myRecordService.getMySubjectBasicInfo(studentId: studentId) { res, err in
            if let res = res {
                subjectList = res
            }
        }
    }
    
    func getAttendanceInfoList () {
        attendanceService.getAttendanceInfo() { res , error in
            if let res = res {
                attendanceList = res
            }
        }
    }
}

#Preview {
    MyRecordView()
}
