//
//  RecordDto.swift
//  autoCheck
//
//  Created by 방성환 on 2023/09/24.
//

import Foundation

struct Record: Codable, Hashable{
    var subject: String
    var attendance: String
    var time: String
}
