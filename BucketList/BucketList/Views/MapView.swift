//
//  ContentView.swift
//  BucketList
//
//  Created by Sebastian Bușa on 3/3/25.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @State private var viewModel = ViewModel()
    @State private var mapStyleConfig = MapStyleConfig()
    @State private var pickMapStyle = false
    
    var body: some View {
        MapReader { proxy in
            Map(initialPosition: viewModel.startPosition) {
                ForEach(viewModel.locations, id: \.id) { location in
                    Annotation(location.name, coordinate: location.coordinate) {
                        Button {
                            viewModel.selectedPlace = location
                        } label: {
                            Image(systemName: "star.circle")
                                .resizable()
                                .foregroundStyle(.red)
                                .frame(width: 44, height: 44)
                                .background(.white)
                                .clipShape(Circle())
                        }
                    }
                    
                }
            }
            .onTapGesture { position in
                if let coordinate = proxy.convert(position, from: .local) {
                    viewModel.addLocation(at: coordinate)
                }
            }
            .sheet(item: Binding(
                get: { viewModel.selectedPlace },
                set: { viewModel.selectedPlace = $0 }
            )) { place in
                NewLocationView(location: place) {
                    viewModel.update(location: $0)
                }
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
            }
            .mapStyle(mapStyleConfig.mapStyle)
            .safeAreaInset(edge: .bottom, alignment: .trailing) {
                Button {
                    pickMapStyle.toggle()
                } label: {
                    // TODO: Change the icon to something more suggestive
                    Image(systemName: "globe.americas.fill")
                        .imageScale(.large)
                }
                .padding(8)
                .background(.thickMaterial)
                .clipShape(.circle)
                .sheet(isPresented: $pickMapStyle) {
                    MapStyleView(mapStyleConfig: $mapStyleConfig)
                        .presentationDetents([.height(275)])
                }
            }
        }
    }
}

#Preview {
    MapView()
}
