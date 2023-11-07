//
//  dynamicIslandLiveActivity.swift
//  dynamicIsland
//
//  Created by seonghwan on 11/8/23.
//

import ActivityKit
import Foundation

struct dynamicIslandAttributes: ActivityAttributes {
    public typealias dynamicStatus = ContentState
    
    public struct ContentState: Codable, Hashable {
        var time: String
        var text: String
        var subject: String?
        var classroom: String?
    }

    // Fixed non-changing properties about your activity go here!
//    var name: String
}
