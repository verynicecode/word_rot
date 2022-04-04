import Foundation

class Tile: ObservableObject, Identifiable {
    @Published var letter: String
    @Published var rotLevel: Int
    @Published var racked = false
    
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
    }
    
    func update() {
        racked.toggle()
    }
    
    func update(gameId: Int) {
        guard let newRecord = TileRecord.findBy(gameId: gameId, row: record.row, column: record.column) else { return }
        
        self.record = newRecord
        self.letter = newRecord.letter
        self.rotLevel = newRecord.decomp
    }
}
