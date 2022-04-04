import SwiftUI

struct TitleScreen: View {
    @State private var showGameView = false
    @ObservedObject var game: Game = GameStore.shared.game
    
    var body: some View {
        let startLabel = game.record.status == "started" ? "resume" : "start"
        
        NavigationView {
            VStack {
                Text("word rot".uppercased())
                    .foregroundColor(Color.complete)
                    .font(Font.futura(60))
                Text("spell words, avoid rot")
                    .font(Font.futura(30))
                Spacer()
                RottenButton(startLabel, action: handleStartTap)
                NavigationLink(destination: GameScreen(), isActive: $showGameView) { EmptyView() }
                Spacer().frame(height: 30)
                RottenLink("scores", destination: ScoresScreen())
                Spacer()
            }
        }
    }
    
    func handleStartTap() {
        GameStore.shared.start()
        showGameView = true
    }
}

struct TitleScreen_Previews: PreviewProvider {
    static var previews: some View {
        TitleScreen()
            .preferredColorScheme(.dark)
    }
}
