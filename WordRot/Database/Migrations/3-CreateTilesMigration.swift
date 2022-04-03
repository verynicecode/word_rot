import Foundation
import SQLite

private let sql = """
CREATE TABLE IF NOT EXISTS tiles(
  id INTEGER PRIMARY KEY,
  game_id INTEGER,
  row INTEGER,
  column INTEGER,
  letter STRING,
  decomp INTEGER,
  rack_position INTEGER,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)
"""

struct CreateTilesMigration: Migration {
    let order: Int32 = 3
    
    func run(client: Connection) {
        try! client.execute(sql)
        client.userVersion = order
    }
}
