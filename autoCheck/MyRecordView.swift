//
//  MyRecordView.swift
//  autoCheck
//
//  Created by 방성환 on 2023/09/24.
//

import SwiftUI

struct MyRecordView: View {
    @Binding private var studentId: String
    @State var subjectList: [String] = ["1", "2", "3"]
    @State var selectedSubject: String = ""
    @State var time: String = ""
    @State var recordList: [Record] = [
        Record(subject: "cap", attendance: "출석", time: "2023/09/22 1220"),
        Record(subject: "java", attendance: "출석", time: "2023/09/22 1230"),
        Record(subject: "spring", attendance: "출석", time: "2023/09/22 2220")
    ]
    
    init(studentId: Binding<String> = .constant("studentId")) {
        _studentId = studentId
    }
    var body: some View {
        VStack {
            Form{
                Section(content: {
                    HStack {
                        Picker("강의명", selection: $selectedSubject) {
                            ForEach(subjectList, id: \.self) { index in
                                Text(index)
                            }
                        }
                        
                        TextField("날짜(1330)", text: $time)
                            .padding(.leading, 20)
                    }
                    HStack {
                        Spacer()
                        Button("검색"){
                            
                        }
                        Spacer()
                    }
                })
                
                Section(content: {
                    List(recordList, id: \.self) { record in
                        HStack {
                            Text(record.subject)
                            Spacer()
                            Text(record.attendance)
                            Spacer()
                            Text(record.time)
                        }
                    }
                })
            }
        }
        .navigationTitle("출석")
        .navigationBarTitleDisplayMode(.automatic)
    }
}

#Preview {
    MyRecordView()
}
