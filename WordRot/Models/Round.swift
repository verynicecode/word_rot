import Foundation
import SQLite

class Round: RottenRecord {
    static let findByGameSql = "SELECT * FROM rounds WHERE game_id = ?;"
    static let createSql = "INSERT INTO rounds(game_id, word, number) VALUES(?, ?, ?);"
    
    let id: Int
    let gameId: Int
    let word: String
    let number: Int
    let createdAt: Date
    let updatedAt: Date
    
    static func findByGame(_ game: Game) -> [Round] {
        let rows = RottenDB.shared.selectRows(findByGameSql, [game.id])
        let rounds = rows.compactMap() { Round(bindings: $0) }
        
        return rounds
    }
    
    static func createFromGame(_ game: Game, word: String) {
        let gameId = game.id
        let nextNumber = game.playedWords.count + 1
        
        try! RottenDB.sharedClient.run(createSql, gameId, word, nextNumber)
    }
    
    init?(bindings: [Binding]) {
        guard
            let id = Round.asInt(bindings[0]),
            let gameId = Round.asInt(bindings[1]),
            let word = Round.asString(bindings[2]),
            let number = Round.asInt(bindings[3]),
            let createdAt = Round.asDate(bindings[4]),
            let updatedAt = Round.asDate(bindings[5])
        else { return nil }
        
        self.id = id
        self.gameId = gameId
        self.word = word
        self.number = number
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
