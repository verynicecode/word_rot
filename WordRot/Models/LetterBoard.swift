import Foundation

typealias LetterPair = (String, Int)

class LetterBoard {
    static func start() -> LetterBoard {
        let data = BoardMaker.fill()
        
        let letterRows: [LetterRow] = data.map { letters in
            let tiles = letters.map() { letterPair in
                return Tile(letter: letterPair.0, rotLevel: letterPair.1)
            }
            
            let row = LetterRow(tiles: tiles)
            
            return row
        }
        
        let letterBoard = LetterBoard(letterRows: letterRows)
        
        return letterBoard
    }
    
    let letterRows: [LetterRow]
    var rackedLetters: [Tile] = []
    
    init(letterRows: [LetterRow]) {
        self.letterRows = letterRows
    }
    
    func rackLetter(tile: Tile) {
        rackedLetters.append(tile)
    }
    
    func removeLastRacked() {
        guard let lastRacked = rackedLetters.last else { return }
        
        lastRacked.racked.toggle()
        rackedLetters.removeLast()
    }
}
