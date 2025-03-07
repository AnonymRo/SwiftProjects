//
//  Quiz.swift
//  GuessTheFlag
//
//  Created by Sebastian Bușa on 6/3/25.
//

import Foundation

struct QuizGame {
    let maxRounds = 8
    var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"]
    var correctAnswer: Int = Int.random(in: 0...2)
    var userScore = 0
    var roundCounter = 1
    
    mutating func shuffleCountries() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    mutating func restartGame() {
        userScore = 0
        roundCounter = 1
        shuffleCountries()
    }
    
}
