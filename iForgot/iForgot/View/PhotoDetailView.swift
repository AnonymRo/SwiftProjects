//
//  PhotoDetailView.swift
//  iForgot
//
//  Created by Sebastian Bușa on 10/3/25.
//

import SwiftUI
import MapKit

struct PhotoDetailView: View {
    let user: User
    
    var body: some View {
        VStack {
            Image(uiImage: UIImage(data: user.photo) ?? UIImage(systemName: "person.crop.circle")!)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 400)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding()
            
            Text(user.name)
                .font(.title.bold())
                .padding()
            
            Spacer()
            
            if let location = user.location {
                MapView(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
                    .frame(height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
            } else {
                Text("Location not available")
                    .foregroundStyle(.gray)
            }
        }
        .navigationTitle("Photo Details")
    }
}

#Preview {
    PhotoDetailView(user: User())
}
