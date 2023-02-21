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
                    .font(.futura(60))
                
                Text("spell words, avoid rot")
                    .font(.futura(30))
                
                Spacer()
                
                NavigationLink(destination: GameScreen(), isActive: $showGameView) {
                    EmptyView()
                }
                
                VStack(spacing: 20) {
                    RottenButton(startLabel, action: handleStartTap)
                    RottenLink("scores", destination: ScoresScreen())
                    RottenLink("rules", destination: RulesScreen())
                }
                
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
