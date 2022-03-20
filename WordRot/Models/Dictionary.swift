import Foundation
import SQLite

class Dictionary {
    static let shared = Dictionary()
    
    private let client: Connection
    
    init() {
        let location = Bundle.main.path(forResource: "rotten.sqlite3", ofType: nil)!
        let client = try! Connection(location)
        self.client = client
    }
    
    func isValid(_ word: String) -> Bool {
        let query = "select count(*) from words where word = '\(word)'"
        let count = try! client.scalar(query) as! Int64
        return count == 1
    }
}
