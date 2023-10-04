//
//  MyRecordService.swift
//  autoCheck
//
//  Created by seonghwan on 10/3/23.
//

import Foundation
import Alamofire

class MyRecordService {
    private var baseUrl = API_SET()
    
    func getMyHistoryList(studentId: String, historyDto: RecordParamDto, result: @escaping([GetHistoryDto]?, Error?) -> Void){
        AF.request(baseUrl.getBaseUrl() + "/ysu/user/history/list/\(studentId)?subjectId=\(historyDto.subjectId)&strCreatedAt=\(historyDto.strCreatedAt)&attendance=\(historyDto.attendance)", method: .get).responseJSON { resonse in
            switch resonse.result {
            case.success(let value):
                print(value)
                do {
                    let decoder = JSONDecoder()
                    let res = try decoder.decode([GetHistoryDto].self, from: value as! Data)
                    result(res, nil)
                } catch {
                    result(nil, error)
                }
            case.failure(let error):
                print(error)
                result(nil, error)
            }
        }
    }
    
}
