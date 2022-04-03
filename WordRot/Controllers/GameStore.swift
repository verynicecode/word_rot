import Foundation

class GameStore: ObservableObject {
    static let shared = GameStore()
    
    @Published var game: Game
        
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
