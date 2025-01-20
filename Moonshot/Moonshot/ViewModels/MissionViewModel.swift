//
//  MissionViewModel.swift
//  Moonshot
//
//  Created by Sebastian Bușa on 20/1/25.
//

import Foundation

final class MissionViewModel: ObservableObject {
    let mission: Mission
    let crew: [CrewMember]
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
    
    var displayName: String {
        mission.displayName
    }
    
    var formattedLaunchDate: String {
        mission.formattedLaunchDate
    }
    
    var missionDescription: String {
        mission.description
    }
    
    var missionImage: String {
        mission.image
    }
}
