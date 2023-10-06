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
    
    func getTodayStudnetAttendaceInfo(studentId: String, result: @escaping(TodayStudentAttendanceInfoDto?, Error?) -> Void) {
        AF.request(baseUrl.getBaseUrl() + "/ysu/attendance/today/\(studentId)", method: .get).responseData { res in
            switch res.result {
            case.success(let value):
                do {
                    let decoder = JSONDecoder()
                    let decoderResult = try decoder.decode(TodayStudentAttendanceInfoDto.self, from: value)
                    DispatchQueue.main.async {
                        result(decoderResult, nil)
                    }
                } catch {
                    result(nil, error)
                }
            case.failure(let error):
                result(nil, error)
            }
        }
    }
    
    func getAttendanceInfo(result: @escaping([AttendanceInfoDto]?, Error?) -> Void) {
        AF.request(baseUrl.getBaseUrl() + "/ysu/attendance/list", method: .get).responseData { response in
            switch response.result {
            case.success(let value):
                do {
                    let decoder = JSONDecoder()
                    let res = try decoder.decode([AttendanceInfoDto].self, from: value as! Data)
                    result(res, nil)
                } catch {
                    result(nil, error)
                }
            case.failure(let error):
                result(nil, error)
            }
        }
    }
    
    func saveAttendance(param: SSAADto, result: @escaping(SubjectAttendance?, Error?) -> Void) {
        AF.request(baseUrl.getBaseUrl() + "/ysu/attendance/save", method: .post, parameters: param, encoder: JSONParameterEncoder.default).responseJSON { res in
            if res.response?.statusCode == 200 {
                switch res.result {
                case.success(let value):
                    do {
                        let decoder = JSONDecoder()
                        let res = try decoder.decode(SubjectAttendance.self, from: value as! Data)
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
}
