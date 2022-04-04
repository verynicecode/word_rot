import Foundation

class GameStore {
    static let shared = GameStore()
    
    let game: Game
        
    init() {
        self.game = Game.findOrCreate()
    }
    
    func start() {
        game.start()
    }
    
    func finish() {
        game.finish()
        game.create()
    }
    
    func rack(tile: Tile) {
        tile.rack()
        game.reload(id: game.record.id)
    }
    
    func unrack(tile: Tile) {
        tile.unrack()
        game.reload(id: game.record.id)
    }
    
    func deleteLastRacked() {
        let lastTile = game.tiles.filter { $0.racked }.sorted { $0.record.rackPosition! < $1.record.rackPosition! }.last
        lastTile?.unrack()
        game.reload(id: game.record.id)
    }
    
    func playWord() {
        game.playWord()
    }
}
