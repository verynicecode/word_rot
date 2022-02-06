//
//  TitleScreen.swift
//  WordRot
//
//  Created by Jonathan Allured on 2/5/22.
//

import SwiftUI

class Game: ObservableObject {
    @Published var isActive = false
}

struct TitleScreen: View {
    @State private var showGame = false
    @ObservedObject private var game = Game()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("word rot").foregroundColor(.black)
                NavigationLink(destination: ContentView(), isActive: $game.isActive) { EmptyView() }
                Button(action: startGame) {
                    Text("start")
                }
                .buttonStyle(.bordered)
                .foregroundColor(.black)
            }
        }
        .environmentObject(game)
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
