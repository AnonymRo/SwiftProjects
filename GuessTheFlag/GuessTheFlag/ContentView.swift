//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Sebastian Bușa on 11/12/24.
//

import SwiftUI

struct ContentView: View {
    
    private let maxRounds = 8
    
    @State private var showingScore = false
    @State private var showingFinalScore = false
    @State private var scoreTitle = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var userScore = 0
    @State private var roundCounter = 1
    @State private var rotationAngle = [0.0, 0.0, 0.0]
    @State private var tappedFlag: Int? = nil
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
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
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(.rect(cornerRadius: 20))
                    
                    ForEach(0..<3) { number in
                        Button {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                rotationAngle[number] += 360
                                tappedFlag = number
                            }
                            flagTapped(number)
                        } label: {
                            FlagImageView(imageName: countries[number])
                        }
                        .rotationEffect(.degrees(rotationAngle[number]))
                        .opacity(tappedFlag == nil || tappedFlag == number ? 1.0 : 0.5)
                        .scaleEffect(tappedFlag == nil || tappedFlag == number ? 1.0 : 0.8)
                    }
                }
                
                Spacer()
                Spacer()
                
                Text("Score: \(userScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: nextRound)
        } message: {
            Text("Your score is now \(userScore)")
        }
        .alert("Game over", isPresented: $showingFinalScore) {
            Button("Restart", action: restartGame)
        } message: {
            Text("Your final score is \(userScore) out of \(maxRounds)")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            userScore += 1
        } else {
            scoreTitle = "Wrong! That's \(countries[number])."
            userScore -= 1
        }
        
        showingScore = true
    }
    
    func nextRound() {
        if roundCounter < maxRounds {
            roundCounter += 1
            askQuestion()
        } else {
            showingFinalScore = true
        }
    }
    
    func restartGame() {
        userScore = 0
        roundCounter = 1
        askQuestion()
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        rotationAngle = [0.0, 0.0, 0.0]
        tappedFlag = nil
    }
}

#Preview {
    ContentView()
}
