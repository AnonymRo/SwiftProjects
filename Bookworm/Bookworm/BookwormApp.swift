import SwiftUI
import SwiftData

@main
struct BookwormApp: App {
    @StateObject private var bookViewModel: BookViewModel

    init() {
        do {
            let storeURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("BookwormData.swiftdata")
            let config = ModelConfiguration(url: storeURL)
            
            let container = try ModelContainer(for: Book.self, configurations: config)
            _bookViewModel = StateObject(wrappedValue: BookViewModel(modelContext: container.mainContext))
            print("✅ ModelContainer initialized successfully at: \(storeURL)")
        } catch {
            print("🚨 SwiftData failed to load: \(error.localizedDescription)")
            _bookViewModel = StateObject(wrappedValue: BookViewModel(modelContext: nil))
        }
    }

    var body: some Scene {
        WindowGroup {
            if bookViewModel.hasValidModelContext {
                ContentView()
                    .modelContainer(for: Book.self)
                    .environmentObject(bookViewModel)
            } else {
                Text("SwiftData Error: Check console for details")
            }
        }
    }
}
