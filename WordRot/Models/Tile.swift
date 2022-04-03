import Foundation

class Tile: ObservableObject, Identifiable {
    @Published var letter: String
    @Published var rotLevel: Int
    @Published var racked = false
    
    init(letter: String, rotLevel: Int) {
        self.letter = letter
        self.rotLevel = rotLevel
    }
    
    func update() {
        racked.toggle()
    }
}
