import Foundation

class Tile: ObservableObject, Identifiable {
    @Published var letter: String
    @Published var rotLevel: Int
    @Published var racked: Bool
    
    var record: TileRecord
    
    static func findBy(gameId: Int) -> [Tile] {
        let records = TileRecord.findBy(gameId: gameId)
        let tiles = records.map { Tile(record: $0) }
        
        return tiles
    }
    
    static func findOrCreate(gameId: Int) -> [Tile] {
        let countSql = "SELECT COUNT(*) FROM tiles WHERE game_id = \(gameId);"
        let tileCount = try! RottenDB.sharedClient.scalar(countSql) as! Int64
        
        if tileCount == 0 {
            generateTiles(gameId: gameId)
        }
        
        let tiles = Tile.findBy(gameId: gameId)
        
        return tiles
    }
    
    static func generateTiles(gameId: Int) {
        let data = BoardMaker.fill()
        
        for (row, letters) in data.enumerated() {
            for (column, letterPair) in letters.enumerated() {
                TileRecord.create(gameId: gameId, row: row, column: column, letter: letterPair.0, decomp: letterPair.1)
            }
        }
    }
    
    init(record: TileRecord) {
        self.record = record
        self.letter = record.letter
        self.rotLevel = record.decomp
        self.racked = record.rackPosition != nil
    }
    
    func rack() {
        let nextRackPosition = TileRecord.nextRackPositionFor(record.gameId)
        TileRecord.update(id: record.id, rackPosition: nextRackPosition)
        reload()
    }
    
    func reload() {
        guard let reloadedRecord = TileRecord.findBy(id: record.id) else { return }
        self.record = reloadedRecord
        self.letter = reloadedRecord.letter
        self.rotLevel = reloadedRecord.decomp
        self.racked = reloadedRecord.rackPosition != nil
    }
    
    func update(gameId: Int) {
        guard let newRecord = TileRecord.findBy(gameId: gameId, row: record.row, column: record.column) else { return }
        
        self.record = newRecord
        self.letter = newRecord.letter
        self.rotLevel = newRecord.decomp
        self.racked = newRecord.rackPosition != nil
    }
}
