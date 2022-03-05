import Foundation

typealias LetterPair = (String, Int)

let alphabet = [
    "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
    "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"
]

class LetterBoard {
    static func makeLetterPair() -> LetterPair {
        let initialRot = Int.random(in: 0...5)
        let initialLetterIndex = Int.random(in: 0...25)
        let initialLetter = alphabet[initialLetterIndex]
        
        return (initialLetter, initialRot)
    }
    
    static func start() -> LetterBoard {
        let rows = 5
        let columns = 5
        
        let data: [[LetterPair]] = Array(1...rows).map { _ in
            return Array(1...columns).map { _ in
                return makeLetterPair()
            }
        }
        
        let letterRows: [LetterRow] = data.map { letters in
            let tiles = letters.map() { letterPair in
                return LetterTile(letter: letterPair.0, rotLevel: letterPair.1)
            }
            
            let row = LetterRow(letterTiles: tiles)
            
            return row
        }
        
        let letterBoard = LetterBoard(letterRows: letterRows)
        
        return letterBoard
    }
    
    let letterRows: [LetterRow]
    var rackedLetters: [LetterTile] = []
    
    init(letterRows: [LetterRow]) {
        self.letterRows = letterRows
    }
    
    func rackLetter(letterTile: LetterTile) {
        rackedLetters.append(letterTile)
    }
    
    func removeLastRacked() {
        guard let lastRacked = rackedLetters.last else { return }
        
        lastRacked.racked.toggle()
        rackedLetters.removeLast()
    }
}
