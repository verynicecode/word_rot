import Foundation

class Game: ObservableObject {
    @Published var lastError: String?
    @Published var score = 0
    
    var playedWords: [String] = []
    
    func playWord(_ word: String) {
        guard !playedWords.contains(word) else { lastError = "word already played"; return }
        guard Dictionary.shared.isValid(word) else { lastError = "word not found"; return }
        
        playedWords.append(word)
        score += word.count
        lastError = nil
    }
}
