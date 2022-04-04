import SwiftUI

struct GameScreen: View {
    @Environment(\.dismiss) private var dismiss
        
    @ObservedObject var game: Game = GameStore.shared.game
    
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
            
            TextField("", text: $game.word)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .disabled(true)
                .overlay(Rectangle().fill(Color.complete).frame(height: 10).padding(.top, 65))
                .font(.futura(60))
            
            HStack(spacing: 20) {
                RottenButton("play", action: handlePlayTap)
                
                Spacer()
                
                RottenButton("delete", action: handleDeleteTap)
            }
            
            if let message = game.lastError {
                Text(message)
                    .font(Font.futura(30))
            }
            
            Spacer()

            GeometryReader { proxy in
                VStack() {
                    Spacer()
                    LetterBoardView()
                        .frame(width: proxy.size.width, height: proxy.size.width)
                }
            }
        }
        .padding(20)
        .navigationBarHidden(true)
    }
    
    func handlePlayTap() {
        GameStore.shared.playWord()
    }
    
    func handleDeleteTap() {
        GameStore.shared.deleteLastRacked()
    }
    
    func quitGame() {
        GameStore.shared.finish()
        dismiss()
    }
}

struct GameScreen_Previews: PreviewProvider {
    static var previews: some View {
        GameScreen()
            .preferredColorScheme(.dark)
    }
}
