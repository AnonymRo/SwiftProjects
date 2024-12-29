//
//  ContentView.swift
//  WordScramble
//
//  Created by Sebastian Bușa on 23/12/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle.fill")
                            Text(word)
                        }
                    }
                }
                Section {
                    Text("Your score is: \(usedWords.count)")
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) { } message: {
                Text(errorMessage)
            }
            .toolbar {
                Button("Restart", action: startGame)
            }
        }
    }
    
    func addNewWord() {
        // lowercase and trimm the word, to make sure we don't add duplicates words with different cases
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        // exit if the string is too short
        guard answer.count > 3 || answer == rootWord else {
            wordError(title: "Word is too short", message: "Try thinking about a word longer than 3 characters")
            return
        }
        
        guard answer != rootWord else {
            wordError(title: "Word is identical", message: "Try thinking about a different word")
            return
        }
        
        // extra validation
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Try thinking about another word")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "Try thinking about a word from the root word")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "Try thinking about a real english word")
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        
        newWord = ""
    }
    
    func startGame() {
        // Find the URL for start.txt in our app bundle
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            
            // Load start.txt into a string
            if let startWords = try? String(contentsOf: startWordsURL, encoding: .utf8) {
                
                // Split the string into an array of strings, splitting on a line break
                let allWords = startWords.components(separatedBy: "\n")
                
                // Pick one random word, or use "silkworm" as a sensible default
                rootWord = allWords.randomElement() ?? "silkworm"
                
                //usedWords.removeAll()
                
                // If we are here, it means everything has worked, so we can exit
                return
            }
        }
        
        // If we are here, it means there was a problem - triggers the app to crash
        fatalError("Couldn't load start.txt from bundle")
    }
    
    func isOriginal(word: String) -> Bool {
        // Checking if the word has been introduced before
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspeledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspeledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

#Preview {
    ContentView()
}
