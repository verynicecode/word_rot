import Foundation

class Game: ObservableObject {
    @Published var lastError: String?
    @Published var score = 0
    
    let id: Int
    let letterBoard = LetterBoard.start()
    
    var playedWords: [String] = []
    var rounds: [Round] = []
    
    init() {
        let sql = "INSERT INTO games(status) VALUES('started') RETURNING id;"
        let id = try! RottenDB.sharedClient.scalar(sql) as! Int64
        self.id = Int(id)
    }
    
    func playWord(_ word: String) {
        guard !playedWords.contains(word) else { lastError = "word already played"; return }
        guard word.count > 3 else { lastError = "word too short"; return }
        guard Dictionary.isValid(word) else { lastError = "word not found"; return }
        
        Round.createFromGame(self, word: word)
        
        playedWords.append(word)
        score += word.count
        lastError = nil
        
        refetch()
    }
    
    func refetch() {
        self.rounds = Round.findByGame(self)
    }
}
