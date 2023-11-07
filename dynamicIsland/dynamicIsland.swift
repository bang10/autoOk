//
//  dynamicIsland.swift
//  dynamicIsland
//
//  Created by seonghwan on 11/8/23.
//

import WidgetKit
import SwiftUI
import ActivityKit

struct Time_Widget: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: dynamicIslandAttributes.self) { context in
            TimeTrackingWidgetView(context: context)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    if let subject = context.state.subject {
                        Text("\(subject)")
                    }
                }
                DynamicIslandExpandedRegion(.trailing) {
                    if let classroom = context.state.classroom {
                        Text("\(classroom)")
                    }
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text(context.state.text)
                        .padding(.bottom, 5)
                    Text(context.state.time)
                }
            } compactLeading: {
                Text("\(context.state.time)")
            } compactTrailing: {
                Text("\(context.state.text)")
            } minimal: {
                Text("M")
            }

        }
    }
}

struct TimeTrackingWidgetView: View {
    let context: ActivityViewContext<dynamicIslandAttributes>
    
    var body: some View {
        HStack {
            Text("남은 시간: \(context.state.time)")
                .padding(.leading, 10)
            Spacer()
            Text("\(context.state.text)")
                .padding(.trailing, 10)
        }
    }
}
