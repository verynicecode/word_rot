import Foundation
import SQLite

class Round {
    let record: RoundRecord
    
    static func findBy(gameId: Int) -> [Round] {
        let records = RoundRecord.findBy(gameId: gameId)
        let rounds = records.map { Round(record: $0) }
        
        return rounds
    }
    
    static func create(game: Game, word: String) {
        let gameId = game.record.id
        let nextNumber = game.rounds.count + 1
        RoundRecord.create(gameId: gameId, word: word, number: nextNumber)
    }
    
    init(record: RoundRecord) {
        self.record = record
    }
}
