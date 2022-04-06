import Foundation
import SQLite

class InsulationFinder {
    static func run(gameId: Int) -> [Int] {
        // it's probably wasteful to re-select these things - maybe i should be passing them in?
        let candidateSql = "SELECT * from tiles WHERE game_id = ?;"
        let candidateBindings = [gameId]
        let candidateRows = RottenDB.shared.selectRows(candidateSql, candidateBindings)
        let candidates = candidateRows.map { TileRecord(bindings: $0) }
        
        let unracked = candidates.filter { $0.rackPosition == nil }
        let noRot = unracked.filter { $0.decomp == 0 }
        let insulated = noRot.filter { neighborsInsulate(for: $0, with: candidates) }
        
        return insulated.map(\.id)
    }
    
    static func neighborsInsulate(for tile: TileRecord, with candidates: [TileRecord]) -> Bool {
        let neighborCoordinates: [(Int, Int)] = [
            (tile.row - 1, tile.column), // north
            (tile.row, tile.column + 1), // east
            (tile.row + 1, tile.column), // south
            (tile.row, tile.column - 1)  // west
        ]
        let neighbors = candidates.filter { candidate in neighborCoordinates.contains { neighbor in neighbor.0 == candidate.row && neighbor.1 == candidate.column } }
        return neighbors.allSatisfy { $0.decomp == 0 || $0.rackPosition != nil }
    }
}

class Tile: ObservableObject, Identifiable {
    @Published var letter: String
    @Published var rotLevel: Int
    @Published var racked: Bool
    
    var record: TileRecord
    
    static func updateAll(gameId: Int) {
        // set decomp on racked tiles
        let decompSql = "UPDATE tiles SET decomp = ? WHERE rack_position IS NOT NULL AND game_id = ?;"
        let decompBindings: [Binding] = [0, gameId]
        try! RottenDB.sharedClient.run(decompSql, decompBindings)
        
        // find fully rotten tiles
        let fullyRottenSql = "SELECT id FROM tiles WHERE decomp = ? AND game_id = ?;"
        let fullyRottenBindings: [Binding] = [5, gameId]
        let fullyRottenRows = RottenDB.shared.selectRows(fullyRottenSql, fullyRottenBindings)
        let fullyRottenTileIds = fullyRottenRows.map { Int($0.first as! Int64) }
        
        // find insulated tiles
        let insulatedTileIds: [Int] = InsulationFinder.run(gameId: gameId)
        
        let dontAdvanceTileIds = fullyRottenTileIds + insulatedTileIds
        let notList = dontAdvanceTileIds.map { String($0) }.joined(separator: ", ")
        
        // advance decomp on unplayed tiles
        let advanceSql = "UPDATE tiles SET decomp = decomp + 1 WHERE rack_position IS NULL AND game_id = ? AND id NOT IN (\(notList));"
        let advanceBindings: [Binding] = [gameId]
        try! RottenDB.sharedClient.run(advanceSql, advanceBindings)
        
        // clear rack positions
        let clearSql = "UPDATE tiles SET rack_position = NULL WHERE game_id = ?;"
        let clearBindings = [gameId]
        try! RottenDB.sharedClient.run(clearSql, clearBindings)
    }
    
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
    
    func unrack() {
        TileRecord.update(id: record.id, rackPosition: nil)
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
