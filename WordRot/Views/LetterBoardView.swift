import SwiftUI

struct LetterRowsView: View {
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

struct LetterBoardView: View {
    let updateWord: (String) -> Void
    
    var letterRows: [LetterRow] {
        return GameStore.shared.currentGame.letterBoard.letterRows
    }
    
    var body: some View {
        ZStack() {
            CirclesView()
            LetterRowsView(updateWord: updateWord)
                .background(.ultraThinMaterial)
        }
        .clipped()
    }
}

struct LetterBoardView_Previews: PreviewProvider {
    static var previews: some View {
        func noop(s: String) {}
        return LetterBoardView(updateWord: noop)
            .preferredColorScheme(.dark)
            .frame(width: 300, height: 300)
    }
}
