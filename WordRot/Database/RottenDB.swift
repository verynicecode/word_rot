import Foundation
import SQLite

class RottenDB {
    static private let filename = "rotten.sqlite3"
    static private let fileManager = FileManager.default
    
    static private var documentsUrl: URL {
        return fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    static private var rottenDbPath: String {
        return documentsUrl.appendingPathComponent(filename).path
    }
    
    static let shared = RottenDB()
    
    static var sharedClient: Connection {
        return shared.client
    }
    
    static func ensureDatabaseFile() {
        guard !fileManager.fileExists(atPath: rottenDbPath) else { return }
        
        do {
            let sourcePath = Bundle.main.path(forResource: filename, ofType: nil)!
            try fileManager.copyItem(atPath: sourcePath, toPath: rottenDbPath)
        } catch {
            print("error during file copy: \(error)")
        }
    }
    
    static func establishConnection() -> Connection {
        return try! Connection(rottenDbPath)
    }
    
    private let client: Connection
    
    init() {
        RottenDB.ensureDatabaseFile()
        self.client = RottenDB.establishConnection()
    }
}
