import Foundation

let validWords = [
    "foo",
    "bar"
]

class Game: ObservableObject {
    @Published var isActive = false
    @Published var lastError: String?
    
    func quit() {
        isActive = false
    }
    
    func playWord(_ word: String) {
        guard validWords.contains(word) else { lastError = "word not found"; return }
    }
}
