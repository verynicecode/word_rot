import SwiftUI

struct TitleView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("word rot").foregroundColor(.black)
                NavigationLink("start", destination: GameView(game: Game()))
                    .buttonStyle(.bordered)
                    .foregroundColor(.black)
            }
        }
    }
}

struct TitleScreen_Previews: PreviewProvider {
    static var previews: some View {
        TitleView()
    }
}
