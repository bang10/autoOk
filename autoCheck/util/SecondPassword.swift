//
//  SecondPassword.swift
//  autoCheck
//
//  Created by 방성환 on 9/29/23.
//

import SwiftUI

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
        }
        
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
}

#Preview {
    SecondPassword()
}
