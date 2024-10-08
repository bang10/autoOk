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
                DynamicIslandExpandedRegion(.leading) {}
                DynamicIslandExpandedRegion(.trailing) {}
                DynamicIslandExpandedRegion(.bottom) {
                    VStack(alignment: .leading) {
                        Text("교과명: \(context.state.subjectName)")
                        Text("강의실: \(context.state.classroom)")
                        Text("출석여부: \(context.state.isAttendance)")
                        Text("소요시간: \(context.state.time)")
                    }
                }
            } compactLeading: {
                Text("\(context.state.subjectName)")
            } compactTrailing: {
                Text("\(context.state.isAttendance)")
            } minimal: {
                Text("\(context.state.subjectName)")
            }

        }
    }
}

struct TimeTrackingWidgetView: View {
    let context: ActivityViewContext<dynamicIslandAttributes>
    
    var body: some View {
        HStack {
            Text("교과명: \(context.state.subjectName) \n출석 여부: \(context.state.isAttendance)")
                .padding(.leading, 5)
            Spacer()
            Text("소요시간: ")
                .font(.system(size: 13))
            Text("\(context.state.time)")
                .font(.system(size: 20))
                .padding(.trailing, 10)
        }
    }
    
}

class StopActivity {
    static let shared = StopActivity()
    
    func stop(acticivy: Activity<dynamicIslandAttributes>) async -> Bool {
        for acticivy in Activity<dynamicIslandAttributes>.activities {
            await acticivy.end(dismissalPolicy: .immediate)
        }
        return true
    }
}

