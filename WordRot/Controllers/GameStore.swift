import Foundation

class GameStore {
    static let shared = GameStore()
    
    let game: Game
        
    init() {
        self.game = Game.findOrCreate()
    }
    
    // this isn't being called because the button is actually a link that navigates
    func start() {
        game.start()
    }
    
    func finish() {
        game.finish()
        game.create()
    }
}
