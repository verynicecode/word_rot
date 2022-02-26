import SwiftUI

struct LetterBoardView: View {
    let updateWord: (String) -> Void
    
    var letterRows: [LetterRow] {
        return GameStore.shared.currentGame.letterBoard.letterRows
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(letterRows) { letterRow in
                LetterRowView(letterRow: letterRow, updateWord: updateWord)
            }
        }
    }
}

//struct LetterBoardView_Previews: PreviewProvider {
//    static var previews: some View {
//        LetterBoardView()
//    }
//}
