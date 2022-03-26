import Foundation

class Game: ObservableObject {
    @Published var lastError: String?
    @Published var score = 0
    
    let id: Int
    let letterBoard = LetterBoard.start()
    
    var playedWords: [String] = []
    var rounds: [Round] = []
    
    init() {
        let sql = "insert into games(status) values('started') returning id;"
        let id = try! RottenDB.sharedClient.scalar(sql) as! Int64
        self.id = Int(id)
    }
    
    func playWord(_ word: String) {
        guard !playedWords.contains(word) else { lastError = "word already played"; return }
        guard word.count > 3 else { lastError = "word too short"; return }
        guard Dictionary.isValid(word) else { lastError = "word not found"; return }
        
        let nextRoundNumber = playedWords.count + 1
        let round = Round(gameId: id, word: word, number: nextRoundNumber)
        rounds.append(round)
        
        playedWords.append(word)
        score += word.count
        lastError = nil
    }
}
