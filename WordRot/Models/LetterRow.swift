import Foundation

class LetterRow: Identifiable {
    let letterTiles: [LetterTile]
    
    init(letterTiles: [LetterTile]) {
        self.letterTiles = letterTiles
    }
}
