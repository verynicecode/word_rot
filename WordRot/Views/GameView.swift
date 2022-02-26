import SwiftUI

struct GameView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var word: String = ""
    
    @ObservedObject var game: Game
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("score: \(game.score)")
                .font(Font.futura(30))
            
            RottenLink("words", destination: WordsView(game: game))
            
            TextField("", text: $word)
                .textFieldStyle(.roundedBorder)
            
            HStack(spacing: 20) {
                RottenButton("play", action: playWord)
                
                if let message = game.lastError {
                    Text(message)
                        .font(Font.futura(30))
                }
            }
            
            RottenButton("quit", action: quitGame)
        }
        .padding(20)
        .navigationBarHidden(true)
    }
    
    func playWord() {
        game.playWord(word.lowercased())
        
        if game.lastError == nil {
            word = ""
        }
    }
    
    func quitGame() {
        GameStore.shared.endCurrentGame()
        dismiss()
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        let game = Game()
        GameView(game: game)
    }
}
