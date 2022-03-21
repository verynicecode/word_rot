import Foundation
import SQLite

protocol Migration {
    var order: Int32 { get }
    func run(client: Connection) -> Void
}
