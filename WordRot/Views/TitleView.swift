import SwiftUI

struct TitleView: View {
    @ObservedObject var store: GameStore
    
    var body: some View {
        let gameView = GameView(game: store.currentGame)
        
        NavigationView {
            VStack {
                Text("word rot").foregroundColor(.black)
                NavigationLink("start", destination: gameView)
                    .buttonStyle(.bordered)
                    .foregroundColor(.black)
            }
        }
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        let store = GameStore()
        TitleView(store: store)
    }
}
