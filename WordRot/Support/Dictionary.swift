import Foundation
import SQLite

class Dictionary {
    static func isValid(_ word: String) -> Bool {
        let query = "SELECT COUNT(*) FROM words WHERE word = '\(word)';"
        let count = try! RottenDB.sharedClient.scalar(query) as! Int64
        return count == 1
    }
}
