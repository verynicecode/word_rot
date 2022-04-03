import Foundation
import SQLite

struct RoundRecord {
    static func findBy(gameId: Int) -> [RoundRecord] {
        let selectSql = "SELECT * FROM rounds WHERE game_id = ?;"
        let selectBindings = [gameId]
        let bindings = RottenDB.shared.selectRows(selectSql, selectBindings)
        let rounds = bindings.compactMap() { RoundRecord(bindings: $0) }

        return rounds
    }
    
    static func create(gameId: Int, word: String, number: Int) {
        let createSql = "INSERT INTO rounds(game_id, word, number) VALUES(?, ?, ?);"
        let createBindings: [Binding] = [gameId, word, number]
        try! RottenDB.sharedClient.run(createSql, createBindings)
    }
    
    let id: Int
    let gameId: Int
    let word: String
    let number: Int
    
    init(bindings: [Binding]) {
        self.id = Int(bindings[0] as! Int64)
        self.gameId = Int(bindings[1] as! Int64)
        self.word = bindings[2] as! String
        self.number = Int(bindings[3] as! Int64)
    }
}
