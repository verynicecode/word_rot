import Foundation

typealias LetterPair = (String, Int)

class BoardMaker {
    static func fill() -> [[LetterPair]] {
        let rows = 5
        let columns = 5
        
        let totalLetters = rows * columns

        let maker = BoardMaker(totalLetters: totalLetters)
        maker.fill()
        let letters = maker.letters
        
        let data: [[LetterPair]] = Array(0..<rows).map { row in
            return Array(0..<columns).map { column in
                let index = (row * rows) + column
                return letters[index]
            }
        }
        
        return data
    }
    
    let totalLetters: Int
    
    var vowels = [
        "a", "a", "e", "e", "e", "i", "i", "o", "o", "u"
    ]
    
    var consonants = [
        "b", "c", "d", "f", "g", "h",
        "j", "k", "l", "m", "n",
        "p", "q", "r", "s", "t",
        "v", "w", "x", "y", "z"
    ]
    
    var letters: [LetterPair] = []
    
    init(totalLetters: Int) {
        self.totalLetters = totalLetters
    }
    
    func fill() {
        addVowels()
        addDupes()
        addConsonants()
        shuffleLetters()
    }
    
    func addVowels() {
        let vowelCount = Int.random(in: 3...6)
        
        for _ in 1...vowelCount {
            let letter = vowels.remove(at: Int.random(in: 0..<vowels.count))
            letters.append((letter, 1))
        }
    }
    
    func addDupes() {
        let dupeCount = Int.random(in: 1...3)
        
        for _ in 1...dupeCount {
            let letter = consonants.remove(at: Int.random(in: 0..<consonants.count))
            letters.append((letter, 1))
            letters.append((letter, 1))
        }
    }
    
    func addConsonants() {
        let remainingCount = totalLetters - letters.count
        
        for _ in 1...remainingCount {
            let letter = consonants.remove(at: Int.random(in: 0..<consonants.count))
            letters.append((letter, 1))
        }
    }
    
    func shuffleLetters() {
        letters.shuffle()
    }
}
