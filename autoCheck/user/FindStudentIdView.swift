//
//  FindStudentId.swift
//  autoCheck
//
//  Created by 방성환 on 2023/09/24.
//

import SwiftUI

struct FindStudentId: View {
    @Environment(\.presentationMode) var presentationMode
    var userService = UserService()
    var authenticationService = AuthenticationService()
    var validityController = ValidityController()
    var alert = Alert()
    @State var studentId: String = ""
    @State var name: String = "방성환"
    @State var tellNumber: String = ""
    @State var authTellNumber: String = ""
    @State var tellAuthNumberCheck: String = String(Double.random(in: 9999999999...99999999999999))
    @State var isFindId: Bool = false
    @State var isTellCheck: Bool = false
    
    var body: some View {
        Form {
            Section (header: Text("이름"),
                     content: {
                TextField("이름을 입력해 주세요.", text: $name)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .disabled(isTellCheck)
            })
            
            Section (
                header: Text("전화번호")
                , content: {
                    TextField("01012345678", text: $tellNumber)
                        .disabled(isTellCheck)
                    HStack {
                        Spacer()
                        Button ("인증 번호 전송") {
                            if validityController.validateTell(tell: tellNumber) {
                                authenticationService.sendSMS(to: tellNumber) { res, error in
                                    if let res = res {
                                        tellAuthNumberCheck = res
                                        alert.alert(message: "인증번호를 작성했어요. \n인증코드를 받지 못했다면 번호를 확인해 주세요.")
                                        isTellCheck = true
                                    } else {
                                        alert.alert(message: "오류가 발생했어요. \n지속적으로 발생한다면 bang369953@gmail.com으로 연락주세요.")
                                    }
                                }
                            } else {
                                alert.alert(message: "전화번호는 숫자만 입력해 주세요.")
                            }
                            
                        }
                        .disabled(isTellCheck)
                        Spacer()
                    }
                    TextField("받은 인증번호를 입력해 주세요.", text: $authTellNumber)
                    HStack {
                        Spacer()
                        Button ("인증") {
                            if tellAuthNumberCheck == authTellNumber {
                                alert.alert(message: "인증에 성공했어요. \n찾기를 눌러주세요.")
                                isFindId = true
                            } else {
                                alert.alert(message: "인증번호가 일치하지 않아요. \n다시 확인해 주세요.")
                            }
                        }
                        .disabled(isFindId)
                        Spacer()
                    }
                }
            )
            
            Section (content: {
                HStack {
                    Spacer()
                    Button("찾기") {
                        userService.findStudentId(findStudentDto: FindStudentDto(studentName: name, tellNumber: tellNumber)) { res, error in
                            if let res = res {
                                alert.alert(message: "학번은 \(res)입니다.")
                            } else {
                                alert.alert(message: "일치하는 정보가 없어요.")
                            }
                        }
                    }
                    .disabled(!isFindId)
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
        .navigationTitle("학번 찾기")
        .navigationBarTitleDisplayMode(.automatic)
    }
}

#Preview {
    FindStudentId()
}
