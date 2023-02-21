import SwiftUI

struct GameScreen: View {
    @Environment(\.dismiss) private var dismiss
        
    @ObservedObject var game: Game = GameStore.shared.game
    
    @State var showMessage = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(spacing: 0) {
                RottenButton("quit", action: quitGame)
                    .frame(width: 100, alignment: .leading)
                
                Spacer(minLength: 0)
                
                Text(String(game.score))
                    .font(Font.futura(60))
                    .scaledToFit()
                    .minimumScaleFactor(0.5)
                
                Spacer(minLength: 0)
                
                RottenLink("words", destination: RoundsScreen(game: game))
                    .frame(width: 100, alignment: .trailing)
            }
            .frame(height: 80)
            
            VStack(spacing: 0) {
                Spacer(minLength: 0)
                TextField("", text: $game.word)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    .disabled(true)
                    .font(.futura(60))
                    .minimumScaleFactor(0.5)
                
                Rectangle()
                    .fill(Color.complete)
                    .frame(height: 10)
                    .padding(.top, -10)
            }
            .frame(height: 80)
            
            HStack(spacing: 20) {
                RottenButton("play") {
                    handlePlayTap()
                    withAnimation(.easeIn(duration: 0.25)) {
                        showMessage = true
                        withAnimation(.easeIn(duration: 0.25).delay(1.5)) {
                            showMessage = false
                        }
                    }
                }
                
                Spacer()
                
                RottenButton("delete", action: handleDeleteTap)
            }
            
            if let message = game.lastError {
                Text(message)
                    .font(Font.futura(30))
                    .opacity(showMessage ? 1 : 0)
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
        let record = GameRecord(id: 1, status: "started")
        let game = Game(record: record, rounds: [], tiles: [])
        game.score = 99
        return GameScreen(game: game)
            .preferredColorScheme(.dark)
    }
}
