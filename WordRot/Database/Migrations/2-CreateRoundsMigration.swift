import Foundation
import SQLite

private let sql = """
CREATE TABLE IF NOT EXISTS rounds(
  id INTEGER PRIMARY KEY,
  game_id INTEGER,
  word STRING,
  number INTEGER,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)
"""

struct CreateRoundsMigration: Migration {
    let order: Int32 = 2
    
    func run(client: Connection) {
        try! client.execute(sql)
        client.userVersion = order
    }
}
