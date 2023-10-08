//
//  ResetPassword.swift
//  autoCheck
//
//  Created by 방성환 on 2023/09/24.
//

import SwiftUI

struct ResetPassword: View {
    @Environment(\.presentationMode) var presentationMode
    var validityController = ValidityController()
    var authenticationService = AuthenticationService()
    var userService = UserService()
    var alert = Alert()
    @State var name: String = ""
    @State var studentId: String = ""
    @State var tellNumber: String = ""
    @State var authTellNumber: String = ""
    @State var tellAuthNumberCheck: String = String(Double.random(in: 9999999999...99999999999999))
    @State var isRestPassword: Bool = false
    @State var isSendTellNumber: Bool = false
    @State var isAuto: Bool = true
    
    var body: some View {
        Form {
            Section (header: Text("이름"),
                     content: {
                TextField("이름을 입력해 주세요.", text: $name)
            })
            .disabled(isSendTellNumber)
            
            Section (header: Text("학번"),
                     content: {
                TextField("학번을 입력해 주세요.", text: $studentId)
            })
            .disabled(isSendTellNumber)
            
            Section (
                header: Text("전화번호")
                , content: {
                    TextField("01012345678", text: $tellNumber)
                        .disabled(isSendTellNumber)
                    HStack {
                        Spacer()
                        Button ("인증 번호 전송") {
                            if validityController.validateTell(tell: tellNumber), name != "", studentId != ""{
                                authenticationService.sendSMS(to: tellNumber) { res, error in
                                    if let res = res {
                                        tellAuthNumberCheck = res
                                        alert.alert(message: "인증번호를 작성했어요. \n인증코드를 받지 못했다면 번호를 확인해 주세요.")
                                        isSendTellNumber = true
                                    } else {
                                        alert.alert(message: "오류가 발생했어요. \n지속적으로 발생한다면 bang369953@gmail.com으로 연락주세요.")
                                    }
                                }
                            } else {
                                alert.alert(message: "미입력 칸이 있거나, 올바른 전화번호 형식이 아닙니다.")
                            }
                        }
                        Spacer()
                    }
                    TextField("받은 인증번호를 입력해 주세요.", text: $authTellNumber)
                    HStack {
                        Spacer()
                        Button ("인증") {
                            if authTellNumber == tellAuthNumberCheck {
                                userService.isUser(findStudentInfo: FindStudentInfoDto(studentName: name, studentId: studentId, tellNumber: tellNumber)) { res in
                                    if let res = res {
                                        if res {
                                            isAuto = false
                                            alert.alert(message: "인증에 성공했어요. 재설정을 눌러주세요.")
                                        } else {
                                            alert.alert(message: "일치하는 정보가 없습니다.")
                                        }
                                    }
                                }
                            } else {
                                alert.alert(message: "인증번호가 일치하지 않아요.")
                            }
                            
                        }
                        Spacer()
                    }
                }
            )
            .disabled(!isAuto)
            
            Section (content: {
                HStack {
                    Spacer()
                    Button("재설정") {
                        isRestPassword.toggle()
                    }
                    .sheet(isPresented: $isRestPassword, content: {
                        ResetPasswordPopup(studentId: $studentId)
                    })
                    .disabled(isAuto)
                    Spacer()
                }
            })
            
            
            Section (content: {
                HStack {
                    Spacer()
                    Button("취소") {
                        presentationMode.wrappedValue.dismiss()
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
