//
//  QuizViewModel.swift
//  GuessTheFlag
//
//  Created by Sebastian Bușa on 6/3/25.
//

import SwiftUI
import Observation

extension QuizView {
    @Observable
    class ViewModel {
        private(set) var game = QuizGame()
        
        var showingScore = false
        var showingFinalScore = false
        var scoreTitle = ""
        var rotationAngle = [0.0, 0.0, 0.0]
        var tappedFlag: Int? = nil
        
        func flagTapped(_ number: Int) {
            animateFlagTap(number)
            updateScore(for: number)
            showingScore = true
        }
        
        private func animateFlagTap(_ number: Int) {
            withAnimation(.easeInOut(duration: 0.5)) {
                rotationAngle[number] += 360
                tappedFlag = number
            }
        }
        
        private func updateScore(for number: Int) {
            if number == game.correctAnswer {
                scoreTitle = "Correct!"
                game.userScore += 1
            } else {
                scoreTitle = "Wrong! That's \(game.countries[number])."
                game.userScore -= 1
            }
        }
        
        func nextRound() {
            if game.roundCounter < game.maxRounds {
                game.roundCounter += 1
                askQuestion()
            } else {
                showingFinalScore = true
            }
        }
        
        func restartGame() {
            game.restartGame()
            resetAnimations()
        }
        
        func askQuestion() {
            game.shuffleCountries()
            resetAnimations()
        }
        
        private func resetAnimations() {
            rotationAngle = [0.0, 0.0, 0.0]
            tappedFlag = nil
        }
    }
}
