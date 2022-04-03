import SwiftUI

struct TitleScreen: View {
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
                RottenLink(startLabel, destination: GameScreen())
                Spacer().frame(height: 30)
                RottenLink("scores", destination: ScoresScreen())
                Spacer()
            }
        }
    }
}

//struct TitleScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        let store = GameStore()
//        TitleScreen(store: store)
//            .preferredColorScheme(.dark)
//    }
//}
