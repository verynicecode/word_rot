import SwiftUI

struct ContentView: View {
    @State private var word: String = ""
    
    @EnvironmentObject var game: Game
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            TextField("", text:$word)
                .textFieldStyle(.roundedBorder)
            
            HStack(spacing: 20) {
                Button(action: playWord) {
                    Text("play")
                }
                .buttonStyle(.bordered)
                .foregroundColor(.black)
                
                if let message = game.lastError {
                  Text(message)
                }
            }
            
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
        game.playWord(word.lowercased())
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
