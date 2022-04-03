import Foundation

class Game: ObservableObject {
    @Published var lastError: String?
    @Published var score: Int
    
    let letterBoard: LetterBoard
    
    var rounds: [Round]
    var record: GameRecord
    
    var playedWords: [String] {
        return rounds.map { $0.record.word }
    }
    
    static func findOrCreate() -> Game {
        if let existingRecord = GameRecord.findBy(status: "created") ?? GameRecord.findBy(status: "started") {
            let rounds = Round.findBy(gameId: existingRecord.id)
            return Game(record: existingRecord, rounds: rounds)
        }
        
        let id = GameRecord.create()
        let record = GameRecord.findBy(id: id)!
        let rounds = Round.findBy(gameId: id)
        
        return Game(record: record, rounds: rounds)
    }
    
    init(record: GameRecord, rounds: [Round]) {
        self.record = record
        self.rounds = rounds
        self.score = rounds.map { $0.record.word.count }.reduce(0, +)
        self.letterBoard = LetterBoard.findOrCreate(gameId: record.id)
    }
    
    func playWord(_ word: String) {
        // this is a hack
        if playedWords.count == 0 {
            start()
        }
        
        guard !playedWords.contains(word) else { lastError = "word already played"; return }
        guard word.count > 3 else { lastError = "word too short"; return }
        guard Dictionary.isValid(word) else { lastError = "word not found"; return }
        
        Round.create(game: self, word: word)
        reload(id: record.id)
        
        lastError = nil
    }
    
    func create() {
        let id = GameRecord.create()
        reload(id: id)
    }
    
    func start() {
        GameRecord.update(id: record.id, status: "started")
        reload(id: record.id)
    }
    
    func finish() {
        GameRecord.update(id: record.id, status: "finished")
        reload(id: record.id)
    }
    
    func reload(id: Int) {
        guard let record = GameRecord.findBy(id: id) else { return }
        self.record = record
        // this isn't quite right because it's creating new instances of the Round classes rather than updating their records but we'll get there!
        let rounds = Round.findBy(gameId: id)
        self.rounds = rounds
        self.score = rounds.map { $0.record.word.count }.reduce(0, +)
    }
}
