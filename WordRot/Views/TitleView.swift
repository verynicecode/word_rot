import SwiftUI

struct TitleView: View {
    @ObservedObject var store: GameStore
    
    var body: some View {
        let gameView = GameView(game: store.currentGame)
        
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

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        let store = GameStore()
        TitleView(store: store)
            .preferredColorScheme(.dark)
    }
}
