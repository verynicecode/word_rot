import SwiftUI

struct TitleScreen: View {
    @State private var showGame = false
    @ObservedObject private var game = Game()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("word rot").foregroundColor(.black)
                NavigationLink(destination: ContentView(game: game), isActive: $game.isActive) { EmptyView() }
                Button(action: startGame) {
                    Text("start")
                }
                .buttonStyle(.bordered)
                .foregroundColor(.black)
            }
        }
    }
    
    func startGame() {
        game.isActive = true
    }
}

struct TitleScreen_Previews: PreviewProvider {
    static var previews: some View {
        TitleScreen()
    }
}
