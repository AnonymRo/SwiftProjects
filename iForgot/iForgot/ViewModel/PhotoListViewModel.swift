//
//  PhotoListViewModel.swift
//  iForgot
//
//  Created by Sebastian Bușa on 10/3/25.
//

import Foundation
import Observation
import PhotosUI
import _PhotosUI_SwiftUI
import SwiftData

extension PhotoListView {
    @Observable
    final class ViewModel {
        var modelContext: ModelContext? = nil
        var users: [User] = []
        
        var selectedItems: [PhotosPickerItem] = []
        var selectedImage: UIImage?
        var imageData: Data?
        var photoName: String = ""
        
        func fetchUsers() {
            let fetchDescriptor = FetchDescriptor<User>(sortBy: [SortDescriptor(\.name)])
            
            users = (try? (modelContext?.fetch(fetchDescriptor) ?? [])) ?? []
        }
        
        func loadImage() {
            Task {
                if let data = try? await selectedItems.first?.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    selectedImage = uiImage
                    imageData = data
                }
            }
        }
        
        func saveUser() {
            guard let imageData, !photoName.isEmpty else { return }
            
            let locationFetcher = LocationFetcher()
            locationFetcher.start()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if let location = locationFetcher.lastKnownLocation {
                    let userLocation = Location(name: "Current Location", latitude: location.latitude, longitude: location.longitude)
                    let newUser = User(photo: imageData, name: self.photoName, location: userLocation)
                    
                    self.modelContext?.insert(newUser)
                    try? self.modelContext?.save()
                    
                    self.resetUI()
                } else {
                    print("Error: Location not available")
                }
            }
        }
        
        func deleteUser(user: User) {
            guard let index = users.firstIndex(where: { $0.id == user.id }) else { return }
            
            modelContext?.delete(users[index])
            try? modelContext?.save()
            
            users.remove(at: index)
        }
        
        func resetUI() {
            selectedImage = nil
            selectedItems.removeAll()
            imageData = nil
            photoName = ""
        }
    }
}
