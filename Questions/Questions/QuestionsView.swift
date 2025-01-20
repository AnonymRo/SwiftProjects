//
//  ContentView.swift
//  Questions
//
//  Created by Sebastian Bușa on 3/1/25.
//

import SwiftUI

struct QuestionsView: View {
    
    @State private var questionsCount: Int = 0
    @State private var generatedQuestions: [String] = []
    @State private var generatedAnswers: [Int] = []
    @State private var isSheetPresented: Bool = false
    @State private var score: Int = 0
    @State private var finishedGame: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section("How many questions do you want?") {
                        StepperView(questionsCount: $questionsCount)
                    }
                    
                    Section {
                        Text(finishedGame ? "Your score is \(score). Congratulations! 🥳" : "Play a game to see your score.")
                            .font(.title3.bold())
                            .transition(.opacity)
                            .animation(.easeInOut, value: finishedGame)
                    }
                    
                    Section {
                        HStack {
                            Spacer()
                            Button("Generate Questions") {
                                withAnimation(.spring()) {
                                    // Generate random questions from user's input
                                    generateRandomQuestions()
                                    // Show the sheet
                                    DispatchQueue.main.async {
                                        isSheetPresented = true
                                    }
                                }
                            }
                            .disabled(questionsCount == 0)
                            .scaleEffect(isSheetPresented ? 1.1 : 1.0)
                            .animation(.spring(), value: isSheetPresented)
                            Spacer()
                        }
                    }
                }
                .navigationTitle("Questions")
                .sheet(isPresented: $isSheetPresented) {
                    // Show generated questions
                    if !generatedQuestions.isEmpty {
                        QuestionsSheetView(questions: generatedQuestions, correctAnswers: generatedAnswers, score: $score, finishedGame: $finishedGame)
                            .presentationDetents([.medium])
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Restart Game") {
                            restartGame()
                        }
                        .buttonStyle(.bordered)
                        .foregroundStyle(.red)
                    }
                }
            }
        }
    }
    
    func generateRandomQuestions() {
        guard questionsCount > 0 else {
            generatedQuestions = []
            generatedAnswers = []
            return
        }
        
        let allQuestions = Questions.questions
        let allAnswers = Questions.answers
        
        // Pair each question with its corresponding answer
        let pairedQuestions = zip(allQuestions, allAnswers).shuffled()
        // After shuffling the tuples, select the first questionsCount elements
        let selectedQuestions = pairedQuestions.prefix(questionsCount)
        
        // Split the tuples back
        generatedQuestions = selectedQuestions.map(\.0)
        generatedAnswers = selectedQuestions.map(\.1)
        
        // Reset the score text
        finishedGame = false
    }
    
    func restartGame() {
        // Reset score
        score = 0
        questionsCount = 0
        generateRandomQuestions()
    }
}

#Preview {
    QuestionsView()
}
