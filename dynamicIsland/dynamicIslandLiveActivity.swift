//
//  dynamicIslandLiveActivity.swift
//  dynamicIsland
//
//  Created by seonghwan on 11/8/23.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct dynamicIslandAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct dynamicIslandLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: dynamicIslandAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension dynamicIslandAttributes {
    fileprivate static var preview: dynamicIslandAttributes {
        dynamicIslandAttributes(name: "World")
    }
}

extension dynamicIslandAttributes.ContentState {
    fileprivate static var smiley: dynamicIslandAttributes.ContentState {
        dynamicIslandAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: dynamicIslandAttributes.ContentState {
         dynamicIslandAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: dynamicIslandAttributes.preview) {
   dynamicIslandLiveActivity()
} contentStates: {
    dynamicIslandAttributes.ContentState.smiley
    dynamicIslandAttributes.ContentState.starEyes
}
