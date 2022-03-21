import Foundation
import SQLite

private let sql = """
create table if not exists games(
  id integer primary key,
  status string,
  created_at default current_timestamp,
  updated_at default current_timestamp
)
"""

struct CreateGamesMigration: Migration {
    let order: Int32 = 1
    
    func run(client: Connection) {
        try! client.execute(sql)
        client.userVersion = order
    }
}
