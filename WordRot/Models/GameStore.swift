import Foundation

class GameStore: ObservableObject {
    static let shared = GameStore()
    
    @Published var currentGame: Game
    
    var games: [Game]
    
    init() {
        let firstGame = Game()
        self.games = [firstGame]
        self.currentGame = firstGame
    }
    
    func endCurrentGame() {
        let newGame = Game()
        self.games.append(newGame)
        self.currentGame = newGame
    }
}
