//
//  ResetPasswordPopup.swift
//  autoCheck
//
//  Created by 방성환 on 2023/09/24.
//

import SwiftUI

struct ResetPasswordPopup: View {
    var userService = UserService()
    var alert = Alert()
    var validityController = ValidityController()
    @Environment(\.presentationMode) var presentationMode
    @State var password: String = ""
    @State var passwordCheck: String = ""
    @State var isUpdatePassword: Bool = false
    @Binding private var studentId: String
    
    init(studentId: Binding<String> = .constant("")) {
        _studentId = studentId
    }
    var body: some View {
        Form {
            Section(header: Text("비밀번호 입력"),
                    content: {
                            SecureField("비밀번호를 입력해 주세요.",
                            text: $password)
                    }
            )
            .disabled(isUpdatePassword)
            
            Section(header: Text("비밀번호 재입력"),
                    content: {
                            SecureField("비밀번호를 다시 입력해 주세요.",
                            text: $passwordCheck)
                    }
            )
            .disabled(isUpdatePassword)
            
            Section (content: {
                HStack {
                    Spacer()
                    Button("확인") {
                        if password == passwordCheck,
                           validityController.validatePassword(password: password) {
                            userService.updatePassword(updatePassword: UpdatePasswordDto(studentId: studentId, newPassword: password)) { res in
                                if let res = res {
                                    if res {
                                        isUpdatePassword = true
                                        alert.alert(message: "성공적으로 변경했어요. 현재 창을 종료해 주세요.")
                                    } else {
                                        alert.alert(message: "비밀번호 변경에 실패했어요.")
                                    }
                                }
                            }

                        } else {
                            password = ""
                            passwordCheck = ""
                            alert.alert(message: "비밀번호가 일치하지 않거나, 비밀번호 형식이 맞지 않아요.영어, 숫자, 특수문자를 조합해서 8자~15자가 되게 해주세요.")
                        }
                    }
                    Spacer()
                }
            })
            .disabled(isUpdatePassword)
            
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
    }
}

#Preview {
    ResetPasswordPopup()
}
