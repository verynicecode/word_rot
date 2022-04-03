import Foundation
import SQLite

private let sql = """
CREATE TABLE IF NOT EXISTS games(
  id INTEGER PRIMARY KEY,
  status STRING,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)
"""

struct CreateGamesMigration: Migration {
    let order: Int32 = 1
    
    func run(client: Connection) {
        try! client.execute(sql)
        client.userVersion = order
    }
}
