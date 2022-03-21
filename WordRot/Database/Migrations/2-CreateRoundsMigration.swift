import Foundation
import SQLite

private let sql = """
create table if not exists rounds(
  id integer primary key,
  game_id integer,
  word string,
  number integer,
  created_at default current_timestamp,
  updated_at default current_timestamp
)
"""

struct CreateRoundsMigration: Migration {
    let order: Int32 = 2
    
    func run(client: Connection) {
        try! client.execute(sql)
        client.userVersion = order
    }
}
