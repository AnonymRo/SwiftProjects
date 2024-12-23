//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Sebastian Bușa on 18/12/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var moves = ["circle.fill", "paperplane.fill", "scissors"]
    @State private var appChoice = Int.random(in: 0...2)
    @State private var isWin = Bool.random()
    @State private var scoreTitle = ""
    @State private var isTapped = false
    @State private var showFinalScore = false
    @State private var userScore = 0
    @State private var roundCounter = 1
    
    private let maxRounds = 10
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                Spacer()
                
                VStack(spacing: 20) {
                    Text("NPC choice")
                        .font(.title.bold())
                        .foregroundStyle(.white)
                    
                    Image(systemName: moves[appChoice])
                        .font(.largeTitle)
                        .frame(width: 70, height: 70)
                        .foregroundStyle(Color(red: 0.76, green: 0.15, blue: 0.26))
                        .background(Color(red: 0.1, green: 0.2, blue: 0.45))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
                Spacer()
                
                VStack {
                    Text("Your choice:")
                        .font(.title.bold())
                        .foregroundStyle(.white)
                    
                    HStack(spacing: 30) {
                        ForEach(0..<3) { symbol in
                            Button {
                                symbolTapped(symbol)
                            } label: {
                                Image(systemName: moves[symbol])
                                    .font(.largeTitle)
                                    .frame(width: 70, height: 70)
                                    .foregroundStyle(Color(red: 0.76, green: 0.15, blue: 0.26))
                                    .background(Color(red: 0.1, green: 0.2, blue: 0.45))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        }
                    }
                }
                
                Spacer()
                
                Text("Score: \(userScore)")
                    .font(.title.bold())
                    .foregroundStyle(.white)
                
                Spacer()
            }
        }
        .alert(scoreTitle, isPresented: $isTapped) {
            Button("Continue", action: nextRound)
        } message: {
            Text("Your score is now \(userScore)")
        }
        .alert(scoreTitle, isPresented: $showFinalScore) {
            Button("Restart", action: restartGame)
        } message: {
            Text("Your final score is \(userScore) out of \(maxRounds)")
        }
    }
    
    func symbolTapped(_ symbol: Int) {
        if (symbol == 0 && appChoice == 2) ||
           (symbol == 1 && appChoice == 0) ||
           (symbol == 2 && appChoice == 1) {
               scoreTitle = "You won!"
               userScore += 1
        } else if symbol == appChoice {
            scoreTitle = "It's a draw!"
        } else {
            scoreTitle = "You lost!"
            userScore -= 1
        }
        
        isTapped = true
    }
    
    func nextRound() {
        if roundCounter < maxRounds {
            roundCounter += 1
            appChoice = Int.random(in: 0...2)
        } else {
            showFinalScore = true
        }
    }
    
    func restartGame() {
        userScore = 0
        roundCounter = 1
        appChoice = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
