//
//  AttendanceService.swift
//  autoCheck
//
//  Created by seonghwan on 10/3/23.
//

import Foundation
import Alamofire

class AttendanceService {
    private var baseUrl = API_SET()
    
    func getTodayStudnetAttendaceInfo(studentId: String, result: @escaping(TodayStudentAttendanceInfoDto?, Error?)->Void) {
        print(studentId)
        AF.request(baseUrl.getBaseUrl() + "/ysu/attendance/today/\(studentId)", method: .get).responseJSON { res in
            print(res)
            switch res.result {
            case.success(let value):
                print(value)
            case.failure(let error):
                result(nil, error)
            }
        }
    }
}
