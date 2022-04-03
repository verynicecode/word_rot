import Foundation
import SQLite

typealias LetterPair = (String, Int)

class LetterBoard {
    static func findOrCreate(gameId: Int) -> LetterBoard {
        let countSql = "SELECT COUNT(*) FROM tiles WHERE game_id = \(gameId);"
        let tileCount = try! RottenDB.sharedClient.scalar(countSql) as! Int64
        
        if tileCount == 0 {
            generateTiles(gameId: gameId)
        }
        
        return start(gameId: gameId)
    }
    
    static func generateTiles(gameId: Int) {
        let data = BoardMaker.fill()
        
        for (row, letters) in data.enumerated() {
            for (column, letterPair) in letters.enumerated() {
                TileRecord.create(gameId: gameId, row: row, column: column, letter: letterPair.0, decomp: letterPair.1)
            }
        }
    }
    
    static func start(gameId: Int) -> LetterBoard {
        let tiles = Tile.findBy(gameId: gameId)
        let letterBoard = LetterBoard(tiles: tiles)
        
        return letterBoard
    }
    
    let tiles: [Tile]
    
    init(tiles: [Tile]) {
        self.tiles = tiles
    }
    
    func rackLetter(letterTile: Tile) {
    }
    
    func removeLastRacked() {
    }
}
