//
//  JoinView.swift
//  autoCheck
//
//  Created by 방성환 on 2023/09/24.
//

import SwiftUI

struct JoinView: View {
    @State var studentId: String = ""
    @State var name: String = ""
    @State var passwrod: String = ""
    @State var birth: String = ""
    @State var tellNubmer: String = ""
    @State var authTellNumber: String = ""
    @State var tellAuthNumberCheck: String = String(Double.random(in: 9999999999...99999999999999))
    @State var secondPassword: String = ""
    @State var secondPasswordCheck: String = ""
    @State var isJoin: Bool = false

    
    var body: some View {
        NavigationView {
            Form {
                Section (
                    header: Text("학번")
                    , content: {
                        TextField("학번을 입력해 주세요.", text: $studentId)
                    }
                )
                
                Section (
                    header: Text("이름")
                    , content: {
                        TextField("학번을 입력해 주세요.", text: $name)
                    }
                )
                
                Section (
                    header: Text("생년월일")
                    , content: {
                        TextField("991030", text: $birth)
                    }
                )
                
                Section (
                    header: Text("전화번호")
                    , content: {
                        TextField("01012345678", text: $tellNubmer)
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
                                
                            }
                            Spacer()
                        }
                    }
                )
                
                Section (
                    header: Text("2차 비밀번호"),
                    content: {
                        SecureField("2차 비밀번호를 입력해 주세요.", text: $secondPassword)
                        SecureField("2차 비밀번호를 다시 입력해 주세요.", text: $secondPasswordCheck)
                    }
                )
                
                Section (
                    content: {
                        HStack {
                            Spacer()
                            Button ("회원 가입") {
                                
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
