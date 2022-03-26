import Foundation

class Round {
    let id: Int
        
    init(gameId: Int, word: String, number: Int) {
        let sql = "insert into rounds(game_id, word, number) values (\(gameId), '\(word)', \(number)) returning id;"
        let id = try! RottenDB.sharedClient.scalar(sql) as! Int64
        self.id = Int(id)
    }
}
