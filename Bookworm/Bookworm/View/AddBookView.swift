//
//  AddBookView.swift
//  Bookworm
//
//  Created by Sebastian Bușa on 11/2/25.
//

import SwiftUI
import SwiftData

struct AddBookView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var bookViewModel: BookViewModel
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var validatingForm: Bool {
        title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
        author.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Enter book details") {
                    TextField("Name of the book", text: $title)
                    TextField("Author of the book", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section("Tell us your oppinion") {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                }
                
                Section("Save your book") {
                    Button("Save") {
                        bookViewModel.addBook(title: title, author: author, genre: genre, review: review, rating: rating)
                        dismiss()
                    }
                    .disabled(validatingForm)
                }
            }
            .navigationTitle("Add Book")
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: Book.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    let modelContext = container.mainContext
    let bookViewModel = BookViewModel(modelContext: modelContext)
    
    AddBookView()
        .environmentObject(bookViewModel)
}
