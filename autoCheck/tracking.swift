//
//  tracking.swift
//  autoCheck
//
//  Created by seonghwan on 11/8/23.
//

import ActivityKit
import Foundation

struct tracking: ActivityAttributes {
    public typealias trackingStatus = ContentSate
    
    public struct ContentSate: Codable, Hashable {
        var startTime: Date
    }
}
