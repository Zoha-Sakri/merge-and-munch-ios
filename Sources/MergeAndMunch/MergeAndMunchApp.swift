import SwiftUI

@main
struct MergeAndMunchApp: App {
    @StateObject private var game = GameStore()
    var body: some Scene { WindowGroup { ContentView().environmentObject(game) } }
}
