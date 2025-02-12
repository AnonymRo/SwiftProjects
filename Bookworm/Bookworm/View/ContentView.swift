//
//  ContentView.swift
//  Bookworm
//
//  Created by Sebastian Bușa on 11/2/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @EnvironmentObject var bookViewModel: BookViewModel
    
    @State private var showingAddBookSheet = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(bookViewModel.books) { book in
                    NavigationLink(value: book) {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading) {
                                Text(book.title)
                                    .font(.headline)
                                
                                Text(book.author)
                                    .foregroundStyle(.secondary)
                            }
                            .foregroundStyle(book.rating == 1 ? Color.red : .primary)
                        }
                    }
                }
                .onDelete { offsets in
                    bookViewModel.deleteBook(at: offsets)
                }
            }
            .navigationTitle("Bookworm")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add book", systemImage: "plus") {
                        showingAddBookSheet.toggle()
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddBookSheet) {
                AddBookView()
            }
            .navigationDestination(for: Book.self) { book in
                DetailView(book: book)
            }
            .onAppear {
                if bookViewModel.books.isEmpty {
                    bookViewModel.fetchBooks()
                }
            }
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: Book.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    let modelContext = container.mainContext
    let bookViewModel = BookViewModel(modelContext: modelContext)
    
    ContentView()
        .environmentObject(bookViewModel)
}
