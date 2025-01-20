//
//  MissionView.swift
//  Moonshot
//
//  Created by Sebastian Bușa on 17/1/25.
//

import SwiftUI

struct MissionView: View {
    
    @StateObject private var viewModel: MissionViewModel
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        _viewModel = StateObject(wrappedValue: MissionViewModel(mission: mission, astronauts: astronauts))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    Image(viewModel.missionImage)
                        .resizable()
                        .scaledToFit()
                        .containerRelativeFrame(.horizontal) { width, axis in
                            width * 0.6
                        }
                        .padding(.top)
                    
                    Text("Launch date: \(viewModel.formattedLaunchDate)")
                        .font(.title2.bold())
                        .foregroundStyle(.lightBackground)
                }
                
                VStack(alignment: .leading) {
                    
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.lightBackground)
                        .padding(.vertical)
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    Text(viewModel.missionDescription)
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.lightBackground)
                        .padding(.vertical)
                    Text("Crew")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                }
                .padding([.horizontal, .top])
                
                HorizontalScrollView(crew: viewModel.crew)
            }
            .padding(.bottom)
        }
        .navigationTitle(viewModel.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    MissionView(mission: missions[1], astronauts: astronauts)
        .preferredColorScheme(.dark)
}
