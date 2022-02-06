//
//  ContentView.swift
//  WordRot
//
//  Created by Jonathan Allured on 1/28/22.
//

import SwiftUI

let validWords = [
    "foo",
    "bar"
]

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
        if validWords.contains(word.lowercased()) {
            word = ""
        } else {
            wordError = true
        }
    }
    
    func quitGame() {
        game.isActive = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
