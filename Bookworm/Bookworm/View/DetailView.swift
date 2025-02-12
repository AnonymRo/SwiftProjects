//
//  DetailView.swift
//  Bookworm
//
//  Created by Sebastian Bușa on 11/2/25.
//

import SwiftUI
import SwiftData

struct DetailView: View {
    
    let book: Book
    
    @EnvironmentObject var bookViewModel: BookViewModel
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre)
                    .resizable()
                    .scaledToFit()
                
                Text(book.genre.uppercased())
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundStyle(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                    .offset(x: -5, y: -5)
            }
            
            Text(book.title)
                .font(.title)
                .foregroundStyle(.primary)
                .multilineTextAlignment(.center)
            
            Text(book.author)
                .font(.title3)
                .foregroundStyle(.secondary)
            
            VStack(spacing: 30) {
                Text(book.review)
                
                RatingView(rating: .constant(book.rating), isEditable: false)
                    .font(.largeTitle)
            }
            .padding()
            
            Text(BookHelper.formattedDate(from: book.date))
                .font(.caption)
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Delete book", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive) {
                bookViewModel.deleteBook(book)
                dismiss()
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure you want to delete \(book.title) ?")
        }
        .toolbar {
            Button("Delete this book", systemImage: "trash") {
                showingDeleteAlert = true
            }
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: Book.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    let modelContext = container.mainContext
    let bookViewModel = BookViewModel(modelContext: modelContext)
    let example = Book(title: "Test Book", author: "Test Author", genre: "Fantasy", review: "This was a really good book.", rating: 4, date: Date.now)
    
    DetailView(book: example)
        .environmentObject(bookViewModel)
}
