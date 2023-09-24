//
//  loginView.swift
//  autoCheck
//
//  Created by 방성환 on 2023/09/22.
//

import SwiftUI

struct LoginView: View {
    var alert = Alert()
    @State private var studentId: String = ""
    @State private var password: String = ""
    @State private var isLogin: Bool = false
    @State private var isAutoLogin: Bool = false
    
    var body: some View {
        NavigationView{
            VStack {
                TextField("학번을 입력해 주세요.", text: $studentId)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                SecureField("비밀번호를 입력해 주세요.", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Toggle(isOn: $isAutoLogin,
                       label: {
                    Text("자동 로그인을 하시려면 선택해 주세요.")
                        .font(.system(size: 15))
                })
                .padding(.bottom, 5)
                
                Button("로그인") {
                    isLogin = true
                }
                .font(.system(size: 20))
                .padding(.top, 5)
                
                //ContentView로 이동
                NavigationLink(destination: ContentView(studentId: $studentId)
                    .navigationBarBackButtonHidden(true), isActive: $isLogin
                ) {
                    EmptyView()
                }
                
                HStack{
                    Spacer()
                    NavigationLink(destination: FindStudentId()) {
                        Text("학번 찾기")
                            .font(.system(size: 20))
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: ResetPassword()) {
                        Text("비밀번호 찾기")
                            .font(.system(size: 20))
                    }
                    
                    Spacer()
                }//HStack
                
                HStack {
                    Spacer()
                    //학번 찾기
                    Spacer()
                    //비밀번호 초기화
                    
                }
                
                NavigationLink(destination: JoinView()) {
                    Text("회원가입")
                        .font(.system(size: 20))
                }
                
            } //VStack
            .padding(.horizontal, 50)
        } //NavigationView
        .navigationTitle("로그인")
        .navigationBarTitleDisplayMode(.automatic)
    }
}

struct loginView_Preview: PreviewProvider {
    static var previews: some View{
        LoginView()
    }
}
