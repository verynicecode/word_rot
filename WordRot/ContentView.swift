//
//  ContentView.swift
//  WordRot
//
//  Created by Jonathan Allured on 1/28/22.
//

import SwiftUI

struct ContentView: View {
    @State private var word: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            TextField("", text:$word)
                .textFieldStyle(.roundedBorder)
            Button(action: playWord) {
                Text("PLAY")
            }
            .buttonStyle(.bordered)
            .foregroundColor(.black)
        }
        .padding(20)
    }
    
    func playWord() {
        word = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
