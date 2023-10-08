//
//  LoginService.swift
//  autoCheck
//
//  Created by 방성환 on 2023/09/23.
//

import Foundation
import Alamofire

class LoginService {
    private var baseUrl = API_SET()
    
    func login(loginDto: LoginDto, res: @escaping(Bool?) -> Void) {
        AF.request(baseUrl.getBaseUrl() + "/ysu/user/login", method: .post, parameters: loginDto, encoder: JSONParameterEncoder.default).responseJSON { result in
            switch result.result {
            case.success(let value) :
                res(value as? Bool)
            case.failure(let error) :
                res(nil)
            }
        }
    }
    
}
