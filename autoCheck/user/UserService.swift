//
//  UserService.swift
//  autoCheck
//
//  Created by seonghwan on 2023/09/27.
//

import Foundation
import Alamofire

class UserService {
    private var baseUrl = API_SET()
    
    func findStudentId(findStudentDto: FindStudentDto, res: @escaping(NSNumber?, Error?) -> Void) {
        AF.request(baseUrl.getBaseUrl() + "/ysu/user/find/studentId", method: .post, parameters: findStudentDto, encoder: JSONParameterEncoder.default).responseJSON { result in
            if result.response?.statusCode == 200 {
                switch result.result {
                case .success(let value):
                    res(value as? NSNumber, nil)
                case.failure(let error):
                    res(nil, error)
                }
            } else {
                res(0, nil)
            }
        }
    }
    
    func isUser(findStudentInfo: FindStudentInfoDto, result: @escaping(Bool?) -> Void) {
        let findStudentInfoDto: [String: Any] = [
                "studentName": findStudentInfo.studentName,
                "studentId": findStudentInfo.studentId,
                "tellNumber": findStudentInfo.tellNumber
            ]
        AF.request(baseUrl.getBaseUrl() + "/ysu/user/find", method: .get, parameters: findStudentInfoDto).responseJSON { res in
            if res.response?.statusCode == 200 {
                switch res.result {
                case.success(let value):
                    result(value as! Bool)
                case.failure(let error):
                    result(false)
                }
            }
        }
    }
    
    func updatePassword(updatePassword: UpdatePasswordDto, result: @escaping(Bool?) -> Void) {
        AF.request(baseUrl.getBaseUrl() + "/ysu/user/update/password", method: .post, parameters: updatePassword, encoder: JSONParameterEncoder.default).responseJSON { res in
            if res.response?.statusCode == 200 {
                switch res.result {
                case.success(let value):
                    result(value as! Bool)
                case.failure(_):
                    result(false)
                }
            }
        }
    }
}
