//
//  ResetPasswordPopup.swift
//  autoCheck
//
//  Created by 방성환 on 2023/09/24.
//

import SwiftUI

struct ResetPasswordPopup: View {
    @State var password: String = ""
    @State var passwordCheck: String = ""
    @Binding private var isRestPassword: Bool
    
    init(isRestPassword: Binding<Bool> = .constant(false)) {
        _isRestPassword = isRestPassword
    }
    var body: some View {
        Form {
            Section(header: Text("비밀번호 입력"),
                    content: {
                            SecureField("비밀번호를 입력해 주세요.",
                            text: $password)
                    }
            )
            
            Section(header: Text("비밀번호 재입력"),
                    content: {
                            SecureField("비밀번호를 다시 입력해 주세요.",
                            text: $passwordCheck)
                    }
            )
            
            Section (content: {
                HStack {
                    Spacer()
                    Button("확인") {
                        
                    }
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
    }
}

#Preview {
    ResetPasswordPopup()
}
