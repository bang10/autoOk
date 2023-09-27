//
//  AuthenticationService.swift
//  autoCheck
//
//  Created by seonghwan on 9/28/23.
//

import Foundation
import Alamofire

class AuthenticationService {
    let baseUrl = API_SET()
    func sendSMS(to: String, completion: @escaping (String?, Error?) -> Void) {
            let parameters: [String: Any] = ["to": to]
            
            AF.request(baseUrl.getBaseUrl() + "/ysu/auth/sms", method: .get, parameters: parameters).responseString { response in
                switch response.result {
                case .success(let value):
                    completion(value, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            }
        }
}
