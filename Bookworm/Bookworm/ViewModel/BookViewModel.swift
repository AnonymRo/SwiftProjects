import Foundation
import SwiftData

class BookViewModel: ObservableObject {
    @Published var books: [Book] = []
    private var modelContext: ModelContext?

    var hasValidModelContext: Bool {
        return modelContext != nil
    }

    init(modelContext: ModelContext?) {
        self.modelContext = modelContext
        fetchBooks()
    }

    func fetchBooks() {
        guard let modelContext else { return }
        do {
            let descriptor = FetchDescriptor<Book>(
                sortBy: [
                    SortDescriptor(\.rating, order: .reverse),
                    SortDescriptor(\.title)
                ])
            books = try modelContext.fetch(descriptor)
        } catch {
            print("Failed to fetch books: \(error.localizedDescription)")
        }
    }

    func addBook(title: String, author: String, genre: String, review: String, rating: Int) {
        guard let modelContext else { return }
        let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating, date: Date.now)
        modelContext.insert(newBook)

        do {
            try modelContext.save()
            fetchBooks()
        } catch {
            print("Failed to save book: \(error.localizedDescription)")
        }
    }

    func deleteBook(_ book: Book? = nil, at offsets: IndexSet? = nil) {
        guard let modelContext else { return }

        if let offsets = offsets {
            for offset in offsets {
                let book = books[offset]
                modelContext.delete(book)
            }
        } else if let book = book {
            modelContext.delete(book)
        }

        do {
            try modelContext.save()
            fetchBooks()
        } catch {
            print("Failed to delete book: \(error.localizedDescription)")
        }
    }
}
