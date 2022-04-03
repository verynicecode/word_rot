import Foundation
import SQLite

struct GameRecord {
    static func findBy(id: Int) -> GameRecord? {
        let selectSql = "SELECT * FROM games WHERE id = ?;"
        let selectBindings = [id]
        guard let bindings = RottenDB.shared.selectRows(selectSql, selectBindings).first else { return nil }
        
        return GameRecord(bindings: bindings)
    }
    
    static func findBy(status: String) -> GameRecord? {
        let selectSql = "SELECT * FROM games WHERE status = ?;"
        let selectBindings = [status]
        guard let bindings = RottenDB.shared.selectRows(selectSql, selectBindings).first else { return nil }
        
        return GameRecord(bindings: bindings)
    }
    
    static func create() -> Int {
        let createSql = "INSERT INTO games(status) VALUES(?) RETURNING id;"
        let createBindings = ["created"]
        let id = try! RottenDB.sharedClient.scalar(createSql, createBindings) as! Int64
        return Int(id)
    }
    
    static func update(id: Int, status: String) {
        // this needs to set the updated at timestamp too!!
        let sql = "UPDATE games SET status = ? WHERE id = ?;"
        let bindings: [Binding] = [status, id]
        try! RottenDB.sharedClient.run(sql, bindings)
    }
    
    let id: Int
    let status: String
    
    init(bindings: [Binding]) {
        self.id = Int(bindings[0] as! Int64)
        self.status = bindings[1] as! String
    }
}
