import Foundation
import SQLite

struct TileRecord {
    static func findBy(gameId: Int) -> [TileRecord] {
        let selectSql = "SELECT * FROM tiles WHERE game_id = ?;"
        let selectBindings = [gameId]
        let bindings = RottenDB.shared.selectRows(selectSql, selectBindings)
        let tiles = bindings.compactMap() { TileRecord(bindings: $0) }

        return tiles
    }
    
    static func findBy(gameId: Int, row: Int, column: Int) -> TileRecord? {
        let selectSql = "SELECT * FROM tiles WHERE game_id = ? AND row = ? AND column = ?;"
        let selectBindings = [gameId, row, column]
        let rows = RottenDB.shared.selectRows(selectSql, selectBindings)
        guard let bindings = rows.first else { return nil }
        
        let newRecord = TileRecord(bindings: bindings)
        return newRecord
    }

    static func create(gameId: Int, row: Int, column: Int, letter: String, decomp: Int) {
        let createSql = "INSERT INTO tiles(game_id, row, column, letter, decomp) VALUES(?, ?, ?, ?, ?);"
        let createBindings: [Binding] = [gameId, row, column, letter, decomp]
        try! RottenDB.sharedClient.run(createSql, createBindings)
    }
    
    let id: Int
    let gameId: Int
    let row: Int
    let column: Int
    let letter: String
    let decomp: Int
    let rackPosition: Int?
    
    init(bindings: [Binding]) {
        self.id = Int(bindings[0] as! Int64)
        self.gameId = Int(bindings[1] as! Int64)
        self.row = Int(bindings[2] as! Int64)
        self.column = Int(bindings[3] as! Int64)
        self.letter = bindings[4] as! String
        self.decomp = Int(bindings[5] as! Int64)
        // need to com back to this...
        self.rackPosition = nil
    }
}
