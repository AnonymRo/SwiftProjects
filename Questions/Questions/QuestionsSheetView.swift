import SwiftUI

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

struct QuestionsSheetView: View {
    
    let questions: [String]
    let correctAnswers: [Int]
    
    @State private var currentQuestionIndex: Int = 0
    @State private var answers: [String] = []
    
    @Binding var score: Int
    @Binding var finishedGame: Bool
    
    @Environment(\.dismiss) private var dismissSheet
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                if !questions.isEmpty {
                    Text(questions[safe: currentQuestionIndex] ?? "Question out of bounds")
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .padding()
                        .transition(.opacity)
                        .animation(.easeInOut, value: currentQuestionIndex)
                    
                    TextField("Your answer", text: Binding(
                        get: { answers.indices.contains(currentQuestionIndex) ? answers[currentQuestionIndex] : "" },
                        set: { newValue in
                            withAnimation {
                                if answers.indices.contains(currentQuestionIndex) {
                                    answers[currentQuestionIndex] = newValue
                                } else {
                                    answers.append(newValue)
                                }
                            }
                        }
                    ))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .padding()
                    
                    Spacer()
                    
                    HStack {
                        if currentQuestionIndex > 0 {
                            Button("Previous") {
                                currentQuestionIndex -= 1
                            }
                            .buttonStyle(.bordered)
                        }
                        
                        Spacer()
                        
                        if currentQuestionIndex < questions.count - 1 {
                            Button("Next") {
                                withAnimation {
                                    // Validate answer and modify score
                                    validateAnswer()
                                    
                                    currentQuestionIndex += 1
                                }
                            }
                            .buttonStyle(.borderedProminent)
                        } else {
                            Button("Finish") {
                                validateAnswer()
                                withAnimation(.easeInOut) {
                                    finishedGame = true
                                    dismissSheet()
                                }
                            }
                            .buttonStyle(.borderedProminent)
                        }
                    }
                } else {
                    Text("No questions available")
                        .font(.title2)
                        .padding()
                }
            }
            .padding()
            .navigationTitle("Question \(currentQuestionIndex + 1) of \(questions.count)")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        dismissSheet()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Text("Score: \(score)")
                        .font(.headline)
                }
            }
        }
    }
    
    private func validateAnswer() {
        guard answers.indices.contains(currentQuestionIndex) else { return }
        
        guard let userAnswer = Int(answers[currentQuestionIndex]) else { return }
        
        if userAnswer == correctAnswers[currentQuestionIndex] {
            score += 1
        } else {
            score -= 1
        }
    }
}

#Preview {
    @Previewable @State var previewScore = 0
    @Previewable @State var previewFinishedGame = false
    QuestionsSheetView(questions: Questions.questions, correctAnswers: Questions.answers, score: $previewScore, finishedGame: $previewFinishedGame)
}
