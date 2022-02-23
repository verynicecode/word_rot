import SwiftUI

struct WordsView: View {
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var game: Game
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            HStack() {
                Text("Played Words")
                Spacer()
                Button("done", action: handleDonePress)
                    .buttonStyle(.bordered)
                    .foregroundColor(.black)
            }
            
            ForEach(game.playedWords, id: \.self) { word in
                Text(word)
            }
            
            Spacer()
        }
        .padding(30)
        .navigationBarBackButtonHidden(true)
    }
    
    func handleDonePress() {
        dismiss()
    }
}

struct WordsView_Previews: PreviewProvider {
    static var previews: some View {
        let game = Game()
        game.playedWords = ["Foo", "Bar"]
        return WordsView(game: game)
    }
}
