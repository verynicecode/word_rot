import SwiftUI

struct TitleScreen: View {
    @ObservedObject var store: GameStore
    
    var body: some View {
        let gameView = GameScreen(game: store.currentGame)
        
        NavigationView {
            VStack {
                Text("word rot".uppercased())
                    .foregroundColor(Color.complete)
                    .font(Font.futura(60))
                Text("spell words, avoid rot")
                    .font(Font.futura(30))
                Spacer()
                RottenLink("start", destination: gameView)
                Spacer()
            }
        }
    }
}

struct TitleScreen_Previews: PreviewProvider {
    static var previews: some View {
        let store = GameStore()
        TitleScreen(store: store)
            .preferredColorScheme(.dark)
    }
}
