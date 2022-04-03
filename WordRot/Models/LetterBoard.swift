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
        let letterRows = tiles.chunked(into: 5).map() { LetterRow(tiles: $0) }
        let letterBoard = LetterBoard(letterRows: letterRows)
        
        return letterBoard
    }
    
    let letterRows: [LetterRow]
    
    init(letterRows: [LetterRow]) {
        self.letterRows = letterRows
    }
    
    func rackLetter(letterTile: Tile) {
    }
    
    func removeLastRacked() {
    }
}
