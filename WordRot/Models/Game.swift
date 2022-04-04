import Foundation

class Game: ObservableObject {
    @Published var lastError: String?
    @Published var score: Int
    
    let tiles: [Tile]
    var rounds: [Round]
    var record: GameRecord
    
    var playedWords: [String] {
        return rounds.map { $0.record.word }
    }
    
    static func findOrCreate() -> Game {
        if let existingRecord = GameRecord.findBy(status: "created") ?? GameRecord.findBy(status: "started") {
            let rounds = Round.findBy(gameId: existingRecord.id)
            let tiles = Tile.findOrCreate(gameId: existingRecord.id)
            return Game(record: existingRecord, rounds: rounds, tiles: tiles)
        }
        
        let id = GameRecord.create()
        let record = GameRecord.findBy(id: id)!
        let rounds = Round.findBy(gameId: id)
        let tiles = Tile.findOrCreate(gameId: record.id)
        
        return Game(record: record, rounds: rounds, tiles: tiles)
    }
    
    init(record: GameRecord, rounds: [Round], tiles: [Tile]) {
        self.record = record
        self.rounds = rounds
        self.score = rounds.map { $0.record.word.count }.reduce(0, +)
        self.tiles = tiles
    }
    
    func playWord(_ word: String) {
        guard !playedWords.contains(word) else { lastError = "word already played"; return }
        guard word.count > 3 else { lastError = "word too short"; return }
        guard Dictionary.isValid(word) else { lastError = "word not found"; return }
        
        Round.create(game: self, word: word)
        reload(id: record.id)
        
        lastError = nil
    }
    
    func create() {
        let id = GameRecord.create()
        Tile.generateTiles(gameId: id)
        tiles.forEach { $0.update(gameId: id) }
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
