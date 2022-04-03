import Foundation

class LetterRow: Identifiable {
    let tiles: [Tile]
    
    init(tiles: [Tile]) {
        self.tiles = tiles
    }
}
