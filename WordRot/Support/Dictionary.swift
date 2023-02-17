import Foundation
import SQLite

class Dictionary {
    static func isValid(_ word: String) -> Bool {
        let query = "SELECT COUNT(*) FROM words WHERE word = '\(word)';"
        
        guard
            let binding = try? RottenDB.sharedClient.scalar(query),
            let count = binding as? Int64
        else { return false }
        
        return count == 1
    }
}
