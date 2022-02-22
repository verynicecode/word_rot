import SwiftUI

struct TitleScreen: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("word rot").foregroundColor(.black)
                NavigationLink("start", destination: ContentView(game: Game()))
                    .buttonStyle(.bordered)
                    .foregroundColor(.black)
            }
        }
    }
}

struct TitleScreen_Previews: PreviewProvider {
    static var previews: some View {
        TitleScreen()
    }
}
