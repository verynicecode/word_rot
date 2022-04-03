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
    
    static func runMigrations(client: Connection) {
        let currentVersion = client.userVersion!
        let migrations: [Migration] = [
            CreateGamesMigration(),
            CreateRoundsMigration(),
            CreateTilesMigration()
        ]
        let missingMigrations = migrations.filter { $0.order > currentVersion }
        missingMigrations.forEach { $0.run(client: client) }
    }
    
    static func establishConnection() -> Connection {
        return try! Connection(rottenDbPath)
    }
    
    private let client: Connection
    
    init() {
        RottenDB.ensureDatabaseFile()
        let client = RottenDB.establishConnection()
        RottenDB.runMigrations(client: client)
        self.client = client
    }
    
    func selectRows(_ selectSql: String, _ bindings: [Binding] = []) -> [[Binding]] {
        guard let statement = try? client.run(selectSql, bindings) else { return [] }
        let rows = statement.compactMap() { element in element.compactMap() { bindings in bindings } }
        return rows
    }
}
