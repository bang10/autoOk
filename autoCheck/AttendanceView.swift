//
//  AttendanceView.swift
//  autoCheck
//
//  Created by 방성환 on 2023/09/24.
//

import SwiftUI

struct AttendanceView: View {
    @Binding private var studentId: String
    @State var lastAttendanceTime: String = "2033/09/24"
    @State var name: String = "방성환"
    @State var department: String = "computer develop"
    @State var isCheckToStr: String = "출석 가능"
    @State var subject: String = "캡스톤 디자인"
    @State var studyTime: String = "2023/09/24 14:30"
    @State var isAttendance: String = "출석 안됨"
    @State var classroom: String = "201"
    @State var grade: String = "1"
    
    init(studentId: Binding<String> = .constant("")) {
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
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color.blue.opacity(0.5))
                        .frame(width: 330, height: 360)
                        .overlay(
                            VStack (){
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
                            }
                        )
                })
                
                Text("이름 : \(name)")
                Text("학번 : \(studentId)")
                Text("학년 : \(grade)")
                Text("소속 : \(department)")
            }
        }
        .navigationTitle("출석")
        .navigationBarTitleDisplayMode(.automatic)
    }
}

#Preview {
    AttendanceView()
}
