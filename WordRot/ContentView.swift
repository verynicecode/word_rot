import SwiftUI

struct ContentView: View {
    @State private var word: String = ""
    @State private var wordError = false
    
    @EnvironmentObject var game: Game
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            if wordError {
              Text("Word Not Found")
            }
            TextField("", text:$word)
                .textFieldStyle(.roundedBorder)
            Button(action: playWord) {
                Text("play")
            }
            .buttonStyle(.bordered)
            .foregroundColor(.black)
            Button(action: quitGame) {
                Text("quit")
            }
            .buttonStyle(.bordered)
            .foregroundColor(.black)
        }
        .padding(20)
        .navigationBarBackButtonHidden(true)
    }
    
    func playWord() {
        if game.isValidWord(word.lowercased()) {
            word = ""
        } else {
            wordError = true
        }
    }
    
    func quitGame() {
        game.quit()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
