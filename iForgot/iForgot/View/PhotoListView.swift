//
//  ContentView.swift
//  iForgot
//
//  Created by Sebastian Bușa on 8/3/25.
//

import SwiftUI
import SwiftData
import PhotosUI
import CoreLocation

struct PhotoListView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                PhotosPicker(selection: $viewModel.selectedItems, matching: .images) {
                    if viewModel.selectedImage != nil {
                        Image(uiImage: viewModel.selectedImage!)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 250)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    } else {
                        ContentUnavailableView("No Picture Selected", systemImage: "photo.badge.plus", description: Text("Tap to import a photo from your library"))
                    }
                }
                .onChange(of: viewModel.selectedItems, initial: false) {
                    viewModel.loadImage()
                    viewModel.fetchUsers()
                }
                
                Group {
                    if viewModel.selectedImage != nil {
                        TextField("Enter your name", text: $viewModel.photoName)
                            .textFieldStyle(.roundedBorder)
                            .padding()
                        
                        Button("Save") {
                            viewModel.saveUser()
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(viewModel.photoName.isEmpty)
                    }
                }
                
                Group {
                    if !viewModel.users.isEmpty {
                        List {
                            ForEach(viewModel.users, id: \.id) { user in
                                NavigationLink(destination: PhotoDetailView(user: user)) {
                                    HStack {
                                        if let image = UIImage(data: user.photo) {
                                            Image(uiImage: image)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 80, height: 80)
                                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                        }
                                        
                                        Text(user.name)
                                            .font(.headline)
                                    }
                                }
                            }
                            .onDelete { indexSet in
                                for index in indexSet {
                                    let user = viewModel.users[index]
                                    viewModel.deleteUser(user: user)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("iForgot")
        }
        .onAppear {
            viewModel.modelContext = modelContext
            viewModel.fetchUsers()
        }
    }
}

#Preview {
    PhotoListView()
        .modelContainer(for: User.self, inMemory: true)
}
