//
//  ContentView.swift
//  HabitTracking
//
//  Created by Sebastian Bușa on 30/1/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var viewModel = ActivityViewModel()
    @State private var isAddingActivity = false
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach($viewModel.activites) { $activity in
                        NavigationLink(destination: ActivityDetailView(viewModel: viewModel, activity: $activity)) {
                            VStack(alignment: .leading) {
                                Text(activity.name)
                                    .font(.title3.bold())
                                Text(activity.description)
                                    .font(.caption.bold())
                            }
                            .padding()
                        }
                    }
                    .onDelete(perform: deleteActivity)
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("", systemImage: "plus") {
                            isAddingActivity.toggle()
                        }
                    }
                }
            }
            .navigationTitle("Track your habits")
            .navigationBarTitleDisplayMode(.inline)
        }
        .sheet(isPresented: $isAddingActivity) {
            NewActivityView(viewModel: viewModel)
                .presentationDetents([.fraction(0.2)])
        }
    }
    
    private func deleteActivity(at offsets: IndexSet) {
        for index in offsets {
            viewModel.removeActivity(at: index)
        }
    }
}

#Preview {
    ContentView()
}
