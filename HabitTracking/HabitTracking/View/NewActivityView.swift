//
//  NewActivityView.swift
//  HabitTracking
//
//  Created by Sebastian Bușa on 30/1/25.
//

import SwiftUI

struct NewActivityView: View {
    
    @State private var activity = Activity(name: "", description: "")
    var viewModel: ActivityViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Activity name", text: $activity.name)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .font(.headline)
                TextField("Description", text: $activity.description)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .font(.headline)
                Button("Add activity") {
                    viewModel.addActivity(activity)
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .navigationTitle("New Activity")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    NewActivityView(viewModel: ActivityViewModel())
}
