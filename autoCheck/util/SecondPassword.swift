//
//  SecondPassword.swift
//  autoCheck
//
//  Created by 방성환 on 9/29/23.
//

import SwiftUI
import LocalAuthentication

struct SecondPassword: View {
    var alert = Alert()
    var fileManageService = FileManageService()
    @State var SecondPassword: String = ""
    @Binding private var studentId: String
    @State var isSecondPassword: Bool = false
    
    init(studentId: Binding<String> = .constant("studentId")) {
        _studentId = studentId
    }
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "key").frame(width: 20)
                    .font(.system(size: 25))
                    .foregroundColor(.gray)
                SecureField("2차 비밀번호", text: $SecondPassword)
                    .frame(width: 300, height: 30)
                    .autocapitalization(.none)
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 2))
            
            Button("확인"){
                if fileManageService.readTextFromFile(fileName: "param.txt") == SecondPassword {
                    isSecondPassword = true
                } else {
                    alert.alert(message: "2차 비밀번호가 일치하지 않아요.")
                    isSecondPassword = false
                }
                
            }
            .font(.system(size: 20))
            .padding(.top, 30)
            
            NavigationLink(destination: ContentView(studentId: $studentId)
                .navigationBarBackButtonHidden(true)
                , isActive: $isSecondPassword
            ) {
                EmptyView()
            }
        }
        .onAppear(perform: {
            authenticateWithBiometrics { result in
                switch result {
                case .success:
                    isSecondPassword = true
                case .failure(let error):
                    isSecondPassword = false
                }
            }
        })
    }
}

func authenticateWithBiometrics(completion: @escaping (Result<Void, Error>) -> Void) {
        let context = LAContext()
        
        // Face ID 또는 Touch ID를 사용하여 인증 시도
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            let reason = "인증이 필요합니다."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        completion(.success(()))
                    } else {
                        if let error = authenticationError {
                            completion(.failure(error))
                        } else {
                            let genericError = NSError(domain: "com.example.app", code: -1, userInfo: nil)
                            completion(.failure(genericError))
                        }
                    }
                }
            }
        } else {
            let notAvailableError = NSError(domain: "com.example.app", code: -2, userInfo: nil)
            completion(.failure(notAvailableError))
        }
}

#Preview {
    SecondPassword()
}
