//
//  NewLocationView.swift
//  BucketList
//
//  Created by Sebastian Bușa on 4/3/25.
//

import SwiftUI

struct NewLocationView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var viewModel: ViewModel
    var onSave: (Location) -> Void
    
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self._viewModel = State(initialValue: ViewModel(location: location))
        self.onSave = onSave
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Name and description") {
                    TextField("Place name", text: $viewModel.name)
                    TextField("Description", text: $viewModel.description)
                }
                
                Section("Nearby attractions") {
                    switch viewModel.loadingState {
                    case .loaded:
                        ForEach(viewModel.pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ") +
                            Text(page.description)
                                .italic()
                        }
                    case .loading:
                        Text("Loading...")
                    case .failed:
                        Text("Please try again later.")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        var newLocation = viewModel.location
                        newLocation.id = UUID()
                        newLocation.name = viewModel.name
                        newLocation.description = viewModel.description
                        
                        onSave(newLocation)
                        dismiss()
                    }
                }
            }
            .task {
                await viewModel.fetchNearbyPlaces()
            }
        }
    }
}

#Preview {
    NewLocationView(location: Location.example) { _ in }
}
