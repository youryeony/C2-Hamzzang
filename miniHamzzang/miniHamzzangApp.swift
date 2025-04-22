
import SwiftUI

@main
struct miniHamzzangApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [Note.self, Hamzzang.self])
        }
    }
}
