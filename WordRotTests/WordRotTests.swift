import XCTest
@testable import WordRot

class WordRotTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testPile() {
        let seed = "7".data(using: .utf8)!
        let pile = LetterPile(seed: seed)
        XCTAssertEqual(pile.letters.count, 100)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
