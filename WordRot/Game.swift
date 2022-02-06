import Foundation

let validWords = [
    "foo",
    "bar"
]

class Game: ObservableObject {
    @Published var isActive = false
    
    func quit() {
        isActive = false
    }
    
    func isValidWord(_ word: String) -> Bool {
        return validWords.contains(word)
    }
}
