import SwiftUI

@main
struct WatchlistApp: App {
    
    var body: some Scene {
        WindowGroup {
            OpeningView()
        }
        .modelContainer(for: User.self)
    }
}

