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
    
    init(record: TileRecord) {
        self.record = record
        self.letter = record.letter
        self.rotLevel = record.decomp
    }
    
    func update() {
        racked.toggle()
    }
}
