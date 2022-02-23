import Foundation

let validWords = [
    "foo",
    "bar"
]

class Game: ObservableObject {
    @Published var lastError: String?
    @Published var score = 0
    
    var playedWords: [String] = []
    
    func playWord(_ word: String) {
        guard validWords.contains(word) else { lastError = "word not found"; return }
        guard !playedWords.contains(word) else { lastError = "word already played"; return }
        
        playedWords.append(word)
        lastError = nil
    }
}
