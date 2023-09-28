//
//  loginView.swift
//  autoCheck
//
//  Created by 방성환 on 2023/09/22.
//

import SwiftUI

struct LoginView: View {
    var alert = Alert()
    var loginService = LoginService()
    @State private var studentId: String = ""
    @State private var password: String = ""
    @State private var isLogin: Bool = false
    @State private var isAutoLogin: Bool = false
    
    var body: some View {
        NavigationView{
            ZStack{
//                LinearGradient(
//                gradient: Gradient(colors: [Color.blue, Color.purple]),
//                startPoint: .topLeading,
//                endPoint: .bottomTrailing
//            )
//            .ignoresSafeArea()
            
                VStack {
                    HStack {
                        Image(systemName: "person").frame(width: 20)
                            .font(.system(size: 25))
                            .foregroundColor(.gray)
                        TextField("학번", text: $studentId)
                            .frame(width: 300, height: 30)
                            .textCase(.lowercase)
                            .autocapitalization(.none)
                            .disableAutocorrection(false)
                            
                    }
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 2))
                    .padding(.bottom, 10)
                    
                    HStack {
                        Image(systemName: "key").frame(width: 20)
                            .font(.system(size: 25))
                            .foregroundColor(.gray)
                        SecureField("생년월일", text: $password)
                            .frame(width: 300, height: 30)
                            .autocapitalization(.none)
                            
                    }
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 2))
                    
                    
                    Toggle(isOn: $isAutoLogin,
                           label: {
                        Text("자동 로그인을 하시려면 선택해 주세요.")
                            .font(.system(size: 15))
                    })
                    .padding(.bottom, 5)
                    
                    Button("로그인") {
                        loginService.login(loginDto: LoginDto(studentId: studentId, password: password)) {res in
                            if let res = res {
                                if res {
                                    isLogin = true
                                } else {
                                    alert.alert(message: "아직 미인증된 학생 계정이에요. 가입일로 부터 최대 3영업일이 소요될 수 있어요.")
                                }
                            } else {
                                alert.alert(message: "일치하는 정보가 없어요")
                            }
                        }
                        
                    }
                    .font(.system(size: 20))
                    .foregroundColor(.black)
        
                    
                    //2차 비밀번호
                    NavigationLink(destination: SecondPassword(studentId: $studentId)
                        , isActive: $isLogin
                    ) {
                        EmptyView()
                    }
                    
                    HStack{
                        Spacer()
                        NavigationLink(destination: FindStudentId()) {
                            Text("학번 찾기")
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                        }
                        
                        Spacer()
                        
                        NavigationLink(destination: ResetPassword()) {
                            Text("비밀번호 초기화")
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                        }
                        
                        Spacer()
                    }//HStack
                    .padding(.top, 10)
                    
                    HStack {
                        Spacer()
                        //학번 찾기
                        Spacer()
                        //비밀번호 초기화
                        
                    }
                    
                    NavigationLink(destination: JoinView()) {
                        Text("회원가입")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                    }
                    
                } //VStack
                .padding(.horizontal, 50)
            }
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
