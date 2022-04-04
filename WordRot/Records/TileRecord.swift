import Foundation
import SQLite

struct TileRecord {
    static func nextRackPositionFor(_ gameId: Int) -> Int {
        let sql = "SELECT rack_position FROM tiles WHERE game_id = ? ORDER BY rack_position DESC LIMIT 1;"
        let bindings = [gameId]
        let result = try! RottenDB.sharedClient.scalar(sql, bindings) as? Int64 ?? 0
        let nextRackPosition = Int(result) + 1
        
        return nextRackPosition
    }
    
    static func findBy(gameId: Int) -> [TileRecord] {
        let selectSql = "SELECT * FROM tiles WHERE game_id = ?;"
        let selectBindings = [gameId]
        let bindings = RottenDB.shared.selectRows(selectSql, selectBindings)
        let tiles = bindings.compactMap() { TileRecord(bindings: $0) }

        return tiles
    }
    
    static func findBy(id: Int) -> TileRecord? {
        let selectSql = "SELECT * FROM tiles WHERE id = ?;"
        let selectBindings = [id]
        let rows = RottenDB.shared.selectRows(selectSql, selectBindings)
        guard let bindings = rows.first else { return nil }
        
        let newRecord = TileRecord(bindings: bindings)
        return newRecord
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
    
    static func update(id: Int, rackPosition: Int?) {
        // this needs to set the updated at timestamp too!!
        let sql = "UPDATE tiles SET rack_position = ? WHERE id = ?;"
        let bindings: [Binding?] = [rackPosition, id]
        try! RottenDB.sharedClient.run(sql, bindings)
    }
    
    let id: Int
    let gameId: Int
    let row: Int
    let column: Int
    let letter: String
    let decomp: Int
    // want to return to this to clean it up
    let rackPosition: Int64?
    
    init(bindings: [Binding]) {
        self.id = Int(bindings[0] as! Int64)
        self.gameId = Int(bindings[1] as! Int64)
        self.row = Int(bindings[2] as! Int64)
        self.column = Int(bindings[3] as! Int64)
        self.letter = bindings[4] as! String
        self.decomp = Int(bindings[5] as! Int64)
        self.rackPosition = bindings[6] as? Int64
    }
    
    init(id: Int, gameId: Int, row: Int, column: Int, letter: String, decomp: Int, rackPosition: Int64?) {
        self.id = id
        self.gameId = gameId
        self.row = row
        self.column = column
        self.letter = letter
        self.decomp = decomp
        self.rackPosition = rackPosition
    }
}
