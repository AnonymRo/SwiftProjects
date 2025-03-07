//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Sebastian Bușa on 11/12/24.
//

import SwiftUI

struct QuizView: View {
    
    @State private var viewModel = ViewModel()
    let countryLabels = CountryLabels()
    
    var body: some View {
        ZStack {
            RadialGradient.appBackground
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text(viewModel.game.countries[viewModel.game.correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(.rect(cornerRadius: 20))
                    
                    ForEach(0..<3) { number in
                        Button {
                            viewModel.flagTapped(number)
                        } label: {
                            FlagImageView(imageName: viewModel.game.countries[number])
                        }
                        .rotationEffect(.degrees(viewModel.rotationAngle[number]))
                        .opacity(viewModel.tappedFlag == nil || viewModel.tappedFlag == number ? 1.0 : 0.5)
                        .scaleEffect(viewModel.tappedFlag == nil || viewModel.tappedFlag == number ? 1.0 : 0.8)
                        .accessibilityLabel(countryLabels.labels[viewModel.game.countries[number], default: "Unknown flag"])
                    }
                }
                
                Spacer()
                Spacer()
                
                Text("Score: \(viewModel.game.userScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(viewModel.scoreTitle, isPresented: $viewModel.showingScore) {
            Button("Continue", action: viewModel.nextRound)
        } message: {
            Text("Your score is now \(viewModel.game.userScore)")
        }
        .alert("Game over", isPresented: $viewModel.showingFinalScore) {
            Button("Restart", action: viewModel.restartGame)
        } message: {
            Text("Your final score is \(viewModel.game.userScore) out of \(viewModel.game.maxRounds)")
        }
    }
}

#Preview {
    QuizView()
}
