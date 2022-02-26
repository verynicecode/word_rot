import SwiftUI

struct GameView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var word: String = ""
    
    @ObservedObject var game: Game
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("score: \(game.score)")
                .font(Font.futura(30))
            
            NavigationLink("words", destination: WordsView(game: game))
                .buttonStyle(.bordered)
                .foregroundColor(Color.white)
                .font(Font.futura(30))
            
            TextField("", text: $word)
                .textFieldStyle(.roundedBorder)
            
            HStack(spacing: 20) {
                Button("play", action: playWord)
                    .buttonStyle(.bordered)
                    .foregroundColor(Color.white)
                    .font(Font.futura(30))
                
                if let message = game.lastError {
                    Text(message)
                        .font(Font.futura(30))
                }
            }
            
            Button("quit", action: quitGame)
                .buttonStyle(.bordered)
                .font(Font.futura(30))
                .foregroundColor(Color.white)
        }
        .padding(20)
        .navigationBarBackButtonHidden(true)
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
