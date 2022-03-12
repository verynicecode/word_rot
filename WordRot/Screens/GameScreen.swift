import SwiftUI

struct GameScreen: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var word: String = ""
    
    @ObservedObject var game: Game
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack() {
                RottenButton("quit", action: quitGame)
                    .frame(width: 100, alignment: .leading)
                
                Spacer()
                
                Text(String(game.score))
                    .font(Font.futura(60))
                
                Spacer()
                
                RottenLink("words", destination: RoundsScreen(game: game))
                    .frame(width: 100, alignment: .trailing)
            }
            
            TextField("", text: $word)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .disabled(true)
                .overlay(Rectangle().fill(Color.complete).frame(height: 10).padding(.top, 65))
                .font(.custom("Futura-Medium", size: 60))
            
            HStack(spacing: 20) {
                RottenButton("play", action: playWord)
                
                Spacer()
                
                RottenButton("delete", action: deleteLetter)
            }
            
            if let message = game.lastError {
                Text(message)
                    .font(Font.futura(30))
            }
            
            Spacer()

            GeometryReader { proxy in
                VStack() {
                    Spacer()
                    LetterBoardView(deleteLetter: deleteLetter, updateWord: updateWord)
                        .frame(width: proxy.size.width, height: proxy.size.width)
                }
            }
        }
        .padding(20)
        .navigationBarHidden(true)
    }
    
    func updateWord(letter: String) {
        word += letter.uppercased()
    }
    
    func playWord() {
        guard word != "" else { return }
        
        game.playWord(word.lowercased())
        
        if game.lastError == nil {
            word = ""
        }
    }
    
    func deleteLetter() {
        guard word != "" else { return }
        
        game.letterBoard.removeLastRacked()
        word.removeLast()
    }
    
    func quitGame() {
        GameStore.shared.endCurrentGame()
        dismiss()
    }
}

struct GameScreen_Previews: PreviewProvider {
    static var previews: some View {
        let game = Game()
        GameScreen(game: game)
            .preferredColorScheme(.dark)
    }
}
