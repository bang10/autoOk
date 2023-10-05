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
        AF.request(baseUrl.getBaseUrl() + "/ysu/user/history/list/\(studentId)?subjectId=\(historyDto.subjectId)&strCreatedAt=\(historyDto.strCreatedAt)&attendanceId=\(historyDto.attendance)", method: .get).responseData { resonse in
            switch resonse.result {
            case.success(let value):
                do {
                    let decoder = JSONDecoder()
                    let res = try decoder.decode([GetHistoryDto].self, from: value as! Data)
                    result(res, nil)
                } catch {
                    result(nil, error)
                }
            case.failure(let error):
                result(nil, error)
            }
        }
    }
    
    func getMySubjectBasicInfo(studentId: String, result: @escaping([SubjectBasicInfoDto]?, Error?) -> Void) {
        AF.request(baseUrl.getBaseUrl() + "/ysu/user/subject/info/\(studentId)", method: .get).responseData { response in
            switch response.result {
            case.success(let value):
                do {
                    let decoder = JSONDecoder()
                    let res = try decoder.decode([SubjectBasicInfoDto].self, from: value as! Data)
                    result(res, nil)
                } catch {
                    result(nil, error)
                }
            case.failure(let error):
                result(nil, error)
            }
        }
    }
    
}
