//
//  ResetPassword.swift
//  autoCheck
//
//  Created by 방성환 on 2023/09/24.
//

import SwiftUI

struct ResetPassword: View {
    var userService = UserService()
    var alert = Alert()
    @State var name: String = "방성환"
    @State var studentId: String = ""
    @State var tellNumber: String = ""
    @State var authTellNumber: String = ""
    @State var tellAuthNumberCheck: String = String(Double.random(in: 9999999999...99999999999999))
    @State var isRestPassword: Bool = false
    
    var body: some View {
        Form {
            Section (header: Text("이름"),
                     content: {
                TextField("이름을 입력해 주세요.", text: $name)
            })
            
            Section (header: Text("학번"),
                     content: {
                TextField("학번을 입력해 주세요.", text: $studentId)
            })
            
            Section (
                header: Text("전화번호")
                , content: {
                    TextField("01012345678", text: $tellNumber)
                    HStack {
                        Spacer()
                        Button ("인증 번호 전송") {
                            
                        }
                        Spacer()
                    }
                    TextField("받은 인증번호를 입력해 주세요.", text: $authTellNumber)
                    HStack {
                        Spacer()
                        Button ("인증") {
                            userService.isUser(findStudentInfo: FindStudentInfoDto(studentName: name, studentId: studentId, tellNumber: tellNumber)) { res in
                                if let res = res {
                                    if res {
                                        alert.alert(message: "success")
                                    } else {
                                        alert.alert(message: "일치하는 정보가 없습니다.")
                                    }
                                }
                            }
                        }
                        Spacer()
                    }
                }
            )
            
            Section (content: {
                HStack {
                    Spacer()
                    Button("재설정") {
                        isRestPassword.toggle()
                    }
                    .sheet(isPresented: $isRestPassword, content: {
                        ResetPasswordPopup(isRestPassword: $isRestPassword)
                    })
                    Spacer()
                }
            })
            
            Section (content: {
                HStack {
                    Spacer()
                    Button("취소") {
                        
                    }
                    Spacer()
                }
            })
        }
        .navigationTitle("본인 인증")
        .navigationBarTitleDisplayMode(.automatic)
    }
}

#Preview {
    ResetPassword()
}
