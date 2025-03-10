//
//  MapView.swift
//  iForgot
//
//  Created by Sebastian Bușa on 10/3/25.
//

import SwiftUI
import MapKit

struct MapView: View {
    let coordinate: CLLocationCoordinate2D
    
    var body: some View {
        Map(initialPosition: .region(
            MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
        )) {
            Marker("Selected Location", coordinate: coordinate)
        }
    }
}

#Preview {
    MapView(coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))
}
