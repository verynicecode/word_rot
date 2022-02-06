import Foundation

let validWords = [
    "foo",
    "bar"
]

class Game: ObservableObject {
    @Published var isActive = false
    
    func isValidWord(_ word: String) -> Bool {
        return validWords.contains(word)
    }
}
