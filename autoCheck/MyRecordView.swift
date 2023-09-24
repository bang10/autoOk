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
                    HStack {
                        Text("과목")
                            .frame(width: 50, alignment: .leading)
                        Spacer()
                        Text("출석결과")
                            .frame(width: 60)
                        Spacer()
                        Spacer()
                        Text("시간")
                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .leading)
                    }
                    List(recordList, id: \.self) { record in
                        HStack {
                            Text(record.subject)
                                .frame(width: 50, alignment: .leading)
                            Spacer()
                            Text(record.attendance)
                                .frame(width: 60)
                            Spacer()
                            Text(record.time)
                                .frame(width: 140)
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
