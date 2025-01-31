//
//  ActivityViewModel.swift
//  HabitTracking
//
//  Created by Sebastian Bușa on 31/1/25.
//

import Foundation
import Observation

@Observable
class ActivityViewModel {
    var activites: [Activity] = []
    
    init() {
        // Load saved activities when the store is initialized
        loadActivities()
    }
    
    func addActivity(_ activity: Activity) {
        guard !activity.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        activites.append(activity)
        saveActivities()
    }
    
    func removeActivity(at index: Int) {
        guard activites.indices.contains(index) else { return }
        activites.remove(at: index)
        saveActivities()
    }
    
    func updateActivity(_ updatedActivity: Activity) {
        if let index = activites.firstIndex(where: { $0.id == updatedActivity.id }) {
            activites[index] = updatedActivity
            saveActivities()
        }
    }
    
    func saveActivities() {
        if let encoded = try? JSONEncoder().encode(activites) {
            UserDefaults.standard.set(encoded, forKey: "savedActivities")
        }
    }
    
    private func loadActivities() {
        if let data = UserDefaults.standard.data(forKey: "savedActivities"),
           let decoded = try? JSONDecoder().decode([Activity].self, from: data) {
            self.activites = decoded
        } else {
            self.activites = []
        }
    }
}

