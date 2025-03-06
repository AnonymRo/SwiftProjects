//
//  MapViewModel.swift
//  BucketList
//
//  Created by Sebastian Bușa on 5/3/25.
//

import Foundation
import Observation
import MapKit
import CoreLocation
import _MapKit_SwiftUI
import LocalAuthentication

extension MapView {
    @Observable
    class ViewModel {
        private(set) var locations: [Location]
        var selectedPlace: Location?
        let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")
        let startPosition = MapCameraPosition.region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
                span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
            )
        )
        
        var authenticationError: String?
        var isShowingAuthError = false
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data")
            }
        }
        
        func addLocation(at point: CLLocationCoordinate2D) {
            authenticate {
                let newLocation = Location(id: UUID(), name: "New Location", description: "", latitude: point.latitude, longitude: point.longitude)
                self.locations.append(newLocation)
                self.save()
            }
        }
        
        func update(location: Location) {
            guard let selectedPlace else { return }
            
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
            }
            save()
        }
        
        func authenticate(success: @escaping () -> Void) {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Please authenticate") {
                    successAuth, authError in
                    
                    DispatchQueue.main.async {
                        if successAuth {
                            success()
                        } else {
                            self.authenticationError = authError?.localizedDescription ?? "Unknown error"
                            self.isShowingAuthError.toggle()
                        }
                    }
                }
            } else {
                authenticationError = error?.localizedDescription ?? "Biometric authentication is not available"
                isShowingAuthError.toggle()
            }
        }
    }
}
