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
}
