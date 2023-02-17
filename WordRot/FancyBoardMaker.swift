import Foundation
import GameKit

class LetterPile {
    static var shared = LetterPile(seed: "7".data(using: .utf8)!)
    
    static let distribution = "A-9, B-2, C-2, D-4, E-12, F-2, G-3, H-2, I-9, J-1, K-1, L-4, M-2, N-6, O-8, P-2, Q-1, R-6, S-4, T-6, U-4, V-2, W-2, X-1, Y-2, Z-1"
    
    static func startingLetters() -> [String] {
        let pairs = distribution.components(separatedBy: ", ")
        
        let nestedLetters: [[String]] = pairs.map { pair in
            let parts = pair.components(separatedBy: "-")
            let letter = parts.first!
            let count = Int(parts.last!)!
            
            return [String](repeating: letter, count: count)
        }
        
        var flattenedLetters = nestedLetters.flatMap { $0 }
        
        // this could be more fancy
        flattenedLetters.append("N")
        flattenedLetters.append("H")
                
        return flattenedLetters
    }
    
    var letters: [String]
    
    private let arc4: GKARC4RandomSource
    
    init(seed: Data) {
        let arc4 = GKARC4RandomSource(seed: seed)
        arc4.dropValues(1024)
        self.arc4 = arc4
        
        self.letters = LetterPile.startingLetters()
    }
    
    func drawLetter() -> String {
        let index = arc4.nextInt(upperBound: letters.count)
        let drawnLetter = letters.remove(at: index)
        print("drawLetter \(drawnLetter)")
        print("letters.count: \(letters.count)")
        return drawnLetter
    }
    
    func drawLetters(_ drawnLetters: [String]) {
        drawnLetters.forEach { letter in
            let index = letters.firstIndex(of: letter)!
            letters.remove(at: index)
        }
        
        print("drawLetters")
        print("letters.count: \(letters.count)")
    }
    
    func returnLetter(letter: String) {
        print("returnLetter \(letter)")
        
        letters.append(letter)
        print("letters.count: \(letters.count)")
    }
}

class FancyBoardMaker {
    private let letterPile: LetterPile
    
    init(seed: Data) {
        self.letterPile = LetterPile(seed: seed)
    }
    
    func fill(word: [String]) -> [String] {
        return []
    }
}
