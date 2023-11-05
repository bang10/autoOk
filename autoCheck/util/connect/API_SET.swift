//
//  API_SET.swift
//  autoCheck
//
//  Created by 방성환 on 2023/09/25.
//

import Foundation

class API_SET {
    private let BASE_URL: String = "http://ysuautocheck.iptime.org:8000"
    
    func getBaseUrl() -> String {
        return BASE_URL;
    }
}
