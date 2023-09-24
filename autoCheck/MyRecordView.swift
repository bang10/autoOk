//
//  MyRecordView.swift
//  autoCheck
//
//  Created by 방성환 on 2023/09/24.
//

import SwiftUI

struct MyRecordView: View {
    @Binding private var studentId: String
    
    init(studentId: Binding<String> = .constant("studentId")) {
        _studentId = studentId
    }
    var body: some View {
        VStack {
            
        }
        .navigationTitle("출석")
        .navigationBarTitleDisplayMode(.automatic)
    }
}

#Preview {
    MyRecordView()
}
