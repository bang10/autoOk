//
//  JoinView.swift
//  autoCheck
//
//  Created by 방성환 on 2023/09/24.
//

import SwiftUI

struct JoinView: View {
    var fileManageService = FileManageService()
    var userService = UserService()
    var authenticationService = AuthenticationService()
    var validityController = ValidityController()
    var alert = Alert()
    @Environment(\.presentationMode) var presentationMode
    @State var studentId: String = ""
    @State var name: String = ""
    @State var passwrod: String = ""
    @State var birth: String = ""
    @State var grade: String = ""
    @State var tellNumber: String = ""
    @State var authTellNumber: String = ""
    @State var tellAuthNumberCheck: String = String(Double.random(in: 9999999999...99999999999999))
    @State var secondPassword: String = ""
    @State var secondPasswordCheck: String = ""
    @State var isJoin: Bool = false
    
    @State var isTellAuth: Bool = false
    @State var isStudentId: Bool = false

    var body: some View {
        NavigationView {
            Form {
                Section (
                    header: Text("학번")
                    , content: {
                        TextField("학번을 입력해 주세요.", text: $studentId)
                        HStack {
                            Spacer()
                            Button("가입확인") {
                                if studentId != "" {
                                    userService.isJoinUser(studentId: studentId) { res in
                                        if let res = res {
                                            if res {
                                                isStudentId = false
                                                alert.alert(message: "이미 가입된 학번이에요.")
                                            } else {
                                                isStudentId = true
                                                alert.alert(message: "가입 가능해요.")
                                            }
                                        }
                                    }
                                } else {
                                    alert.alert(message: "학번을 입력해 주세요.")
                                }
                                
                            }
                            Spacer()
                        }
                    }
                )
                .disabled(isStudentId)
                
                Section (
                    header: Text("이름")
                    , content: {
                        TextField("학번을 입력해 주세요.", text: $name)
                    }
                )
                .disabled(isJoin)
                
                Section (
                    header: Text("생년월일")
                    , content: {
                        TextField("19991030", text: $birth)
                        if !validityController.validateBirth(birth: birth) {
                            Text("올바른 생년월일을 입력해주세요.")
                        }
                    }
                )
                .disabled(isJoin)
                
                Section (
                    header: Text("학년")
                    , content: {
                        TextField("4", text: $grade)
                        if !validityController.validateGrade(grade: grade) {
                            Text("올바른 학년을 입력해 주세요.")
                        }
                    }
                )
                .disabled(isJoin)
                
                Section (
                    header: Text("전화번호")
                    , content: {
                        TextField("01012345678", text: $tellNumber)
                        HStack {
                            Spacer()
                            Button ("인증 번호 전송") {
                                if validityController.validateTell(tell: tellNumber){
                                    authenticationService.sendSMS(to: tellNumber) { res, error in
                                        if let res = res {
                                            tellAuthNumberCheck = res
                                            alert.alert(message: "인증번호를 작성했어요. \n인증코드를 받지 못했다면 번호를 확인해 주세요.")
                                            
                                        } else {
                                            alert.alert(message: "오류가 발생했어요. \n지속적으로 발생한다면 bang369953@gmail.com으로 연락주세요.")
                                        }
                                    }
                                } else {
                                    alert.alert(message: "미입력 칸이 있거나, 올바른 전화번호 형식이 아니에요.")
                                }
                            }
                            Spacer()
                        }
                        TextField("받은 인증번호를 입력해 주세요.", text: $authTellNumber)
                        HStack {
                            Spacer()
                            Button ("인증") {
                                if authTellNumber == tellAuthNumberCheck {
                                    isTellAuth = true
                                    alert.alert(message: "인정번호가 일치해요.")
                                } else {
                                    alert.alert(message: "인증번호가 일치하지 않아요.")
                                }
                            }
                            Spacer()
                        }
                    }
                )
                .disabled(isTellAuth)
                
                Section (
                    header: Text("2차 비밀번호 (4~6자리 숫자)"),
                    content: {
                        SecureField("2차 비밀번호를 입력해 주세요.", text: $secondPassword)
                        SecureField("2차 비밀번호를 다시 입력해 주세요.", text: $secondPasswordCheck)
                    }
                )
                .disabled(isJoin)
                
                Section (
                    content: {
                        HStack {
                            Spacer()
                            Button ("회원 가입") {
                                if validityController.validateSecondPassword(password: secondPassword), secondPasswordCheck == secondPassword {
                                    if isTellAuth {
                                        if isStudentId {
                                            if name != "", validityController.validateBirth(birth: birth), validityController.validateGrade(grade: grade) {
                                                userService.join(joinDto: joinDto(studentId: studentId, name: name, tellNumber: tellNumber, birth: birth, grade: grade)) { res in
                                                    if let res = res {
                                                        if res {
                                                            fileManageService.saveTextToFile(secondPassword, fileName: "param.txt")
                                                            isJoin = true
                                                            alert.alert(message: "성공적으로 가입했어요.")
                                                        } else {
                                                            alert.alert(message: "가입에 실패했어요.")
                                                        }
                                                    }
                                                }
                                            } else {
                                                alert.alert(message: "미입력 칸이 있어요.")
                                            }
                                        } else {
                                            alert.alert(message: "학생번호를 확인해 주세요.")
                                        }
                                    } else {
                                        alert.alert(message: "번호인증이 진행되지 않았어요.")
                                    }
                                } else {
                                    alert.alert(message: "2차 비밀번호를 형식에 맞게 입력해 주세요.")
                                }
                                
                            }
                            Spacer()
                        }
                    }
                )
                
                Section (
                    content: {
                        HStack {
                            Spacer()
                            Button ("취소") {
                                presentationMode.wrappedValue.dismiss()
                            }
                            Spacer()
                        }
                    }
                )
            }
        }
        .navigationTitle("회원가입")
        .navigationBarTitleDisplayMode(.automatic)
    }
}

#Preview {
    JoinView()
}
