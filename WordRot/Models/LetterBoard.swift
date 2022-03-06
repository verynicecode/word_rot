import Foundation

typealias LetterPair = (String, Int)

class LetterBoard {
    static func start() -> LetterBoard {
        let data = BoardMaker.fill()
        
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
