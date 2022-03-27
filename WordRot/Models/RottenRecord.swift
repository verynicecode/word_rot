import Foundation
import SQLite

class RottenRecord {
    static let dateFormatter = ISO8601DateFormatter()
    
    static func asInt(_ binding: Binding) -> Int? {
        return binding as? Int
    }
    
    static func asString(_ binding: Binding) -> String? {
        return binding as? String
    }
    
    static func asDate(_ binding: Binding) -> Date? {
        guard let stringDate = asString(binding) else { return nil }
        return dateFormatter.date(from: stringDate)
    }
}
