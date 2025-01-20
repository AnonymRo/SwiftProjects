//
//  ContentView.swift
//  Moonshot
//
//  Created by Sebastian Bușa on 17/1/25.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isGridView {
                    AstronautsGridView(astronauts: viewModel.astronauts, missions: viewModel.missions)
                } else {
                    AstronautsListView(astronauts: viewModel.astronauts, missions: viewModel.missions)
                }
            }
            .navigationTitle("Moonshot")
            .navigationBarTitleDisplayMode(.inline)
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        withAnimation {
                            viewModel.isGridView.toggle()
                        }
                    } label: {
                        Image(systemName: viewModel.isGridView ? "list.bullet" : "square.grid.2x2")
                            .foregroundStyle(.white)
                    }
                }
            }
        }
    }
}

#Preview {
    MainView()
}
