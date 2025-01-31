//
//  ActivityDetailView.swift
//  HabitTracking
//
//  Created by Sebastian Bușa on 31/1/25.
//

import SwiftUI

struct ActivityDetailView: View {
    
    var viewModel: ActivityViewModel
    @Binding var activity: Activity
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Text(activity.name)
                .font(.largeTitle.bold())
            
            Text(activity.description)
                .font(.body)
            
            Spacer()
            
            Stepper("Completed: \(activity.completionCount) times", onIncrement: {
                incrementActivityCount()
            }, onDecrement: {
                decrementActivityCount()
            })
        }
        .padding()
        .navigationTitle("Activity Details")
    }
    
    private func incrementActivityCount() {
        activity.completionCount += 1
        viewModel.updateActivity(activity)
    }
    
    private func decrementActivityCount() {
        activity.completionCount -= 1
        viewModel.updateActivity(activity)
    }
}

#Preview {
    ActivityDetailView(viewModel: ActivityViewModel(), activity: .constant(Activity(id: UUID(), name: "Test", description: "Test")))
}
