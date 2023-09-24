//
//  FindStudentId.swift
//  autoCheck
//
//  Created by 방성환 on 2023/09/24.
//

import SwiftUI

struct FindStudentId: View {
    @State var name: String = ""
    @State var tellNumber: String = ""
    @State var authTellNumber: String = ""
    @State var tellAuthNumberCheck: String = String(Double.random(in: 9999999999...99999999999999))
    @State var isFindId: Bool = false
    
    var body: some View {
        Form {
            Section (header: Text("이름"),
                     content: {
                TextField("이름을 입력해 주세요.", text: $name)
            })
            
            Section (
                header: Text("전화번호")
                , content: {
                    TextField("01012345678", text: $tellNumber)
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
            
            Section (content: {
                HStack {
                    Spacer()
                    Button("찾기") {
                        
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
        .navigationTitle("학번 찾기")
        .navigationBarTitleDisplayMode(.automatic)
    }
}

#Preview {
    FindStudentId()
}
