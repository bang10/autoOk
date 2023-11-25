//
//  HapticHelper.swift
//  autoCheck
//
//  Created by seonghwan on 11/26/23.
//

import Foundation
import SwiftUI

class HapticHelper {
    
    static let shared = HapticHelper()
    
    private init() { }
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
