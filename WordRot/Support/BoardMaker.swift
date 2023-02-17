import Foundation

typealias LetterPair = (String, Int)

class BoardMaker {
    static func fill() -> [[LetterPair]] {
        let rows = 5
        let columns = 5
        
        let data: [[LetterPair]] = Array(0..<rows).map { row in
            return Array(0..<columns).map { column in
                let letter = LetterPile.shared.drawLetter()
                return (letter, 1)
            }
        }
        
        return data
    }
}
