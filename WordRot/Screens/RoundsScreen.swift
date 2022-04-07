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
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    HStack() {
                        Spacer()
                    }
                    
                    ForEach(game.playedWords, id: \.self) { word in
                        Text(word)
                            .font(Font.futura(20))
                    }
                }
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
        let record = GameRecord(id: 0, status: "created")
        let rounds = [
            Round(record: RoundRecord(id: 0, gameId: 0, word: "Foo", number: 1)),
            Round(record: RoundRecord(id: 0, gameId: 0, word: "Bar", number: 2))
        ]
        let game = Game(record: record, rounds: rounds, tiles: [])
        
        RoundsScreen(game: game).preferredColorScheme(.dark)
    }
}
