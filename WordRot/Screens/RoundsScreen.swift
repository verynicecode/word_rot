import SwiftUI

struct RoundsScreen: View {
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var game: Game
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack() {
                Text("Played Words")
                    .font(Font.futura(30))
                Spacer()
                RottenButton("done", action: handleDonePress)
            }
            
            ForEach(game.playedWords, id: \.self) { word in
                Text(word)
                    .font(Font.futura(20))
            }
            
            Spacer()
        }
        .padding(20)
        .navigationBarHidden(true)
    }
    
    func handleDonePress() {
        dismiss()
    }
}

struct RoundsScreen_Previews: PreviewProvider {
    static var previews: some View {
        let game = Game()
        game.playedWords = ["Foo", "Bar"]
        return RoundsScreen(game: game).preferredColorScheme(.dark)
    }
}
