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
    }
    
    func unrack(tile: Tile) {
        // insert working code here
    }
}
