//
//  MainViewModel.swift
//  Moonshot
//
//  Created by Sebastian Bușa on 20/1/25.
//

import Foundation

final class MainViewModel: ObservableObject {
    @Published var isGridView = true
    @Published var astronauts: [String: Astronaut] = [:]
    @Published var missions: [Mission] = []
    
    init() {
        loadAstronauts()
        loadMissions()
    }
    
    private func loadAstronauts() {
        astronauts = Bundle.main.decode("astronauts.json")
    }
    
    private func loadMissions() {
        missions = Bundle.main.decode("missions.json")
    }
    
    func toggleView() {
        isGridView.toggle()
    }
}
