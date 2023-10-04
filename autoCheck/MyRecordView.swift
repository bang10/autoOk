//
//  MyRecordView.swift
//  autoCheck
//
//  Created by 방성환 on 2023/09/24.
//

import SwiftUI

struct MyRecordView: View {
    private var timeSet = TimeSet()
    private var myRecordService = MyRecordService()
    @Binding private var studentId: String
    @State var subjectList: [String] = ["1", "2", "3"]
    @State var selectedSubject: String = ""
    @State var time: String = ""
    @State var attendance: String = ""
    @State var recordList: [GetHistoryDto] = [
        GetHistoryDto(attendance: "", createdAt: "", name: "")
    ]
    
    init(studentId: Binding<String> = .constant("2018100249")) {
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
                        TextField("출석 여부", text: $attendance)
                    }
                    HStack {
                        Spacer()
                        Button("검색"){
                            getDate()
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
                            Text(record.name)
                                .font(.system(size: 13))
                                .frame(width: 50, alignment: .leading)
                            Spacer()
                            Text(record.attendance)
                                .frame(width: 60)
                            Spacer()
                            Text(timeSet.getTimeTranceString(time: record.createdAt))
                                .frame(width: 140)
                        }
                    }
                })
            }
            .onAppear(perform: {
                getDate()
            })
        }
        .navigationTitle("출석")
        .navigationBarTitleDisplayMode(.automatic)

    }
    
    func getDate() {
        myRecordService.getMyHistoryList(studentId: studentId,historyDto: RecordParamDto(subjectId: selectedSubject, strCreatedAt: time, attendance: attendance)) { res, err in
            if let res = res {
                DispatchQueue.main.async {
                    recordList = res
                }
            }
        }
    }
}

#Preview {
    MyRecordView()
}
