import Foundation
import SQLite

class Dictionary {
    static let shared = Dictionary()
    
    private let client: Connection
    
    init() {
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let location = documentsUrl.appendingPathComponent("rotten.sqlite3").path
        
        let client = try! Connection(location)
        self.client = client
    }
    
    func isValid(_ word: String) -> Bool {
        let query = "select count(*) from words where word = '\(word)'"
        let count = try! client.scalar(query) as! Int64
        return count == 1
    }
}
