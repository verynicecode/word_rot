import SwiftUI

struct LetterRowsView: View {
    let deleteLetter: () -> Void
    let updateWord: (String) -> Void
    
    var letterRows: [LetterRow] {
        return GameStore.shared.game.letterBoard.letterRows
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(letterRows) { letterRow in
                LetterRowView(letterRow: letterRow, deleteLetter: deleteLetter, updateWord: updateWord)
            }
        }
    }
}

struct LetterBoardView: View {
    let deleteLetter: () -> Void
    let updateWord: (String) -> Void
    
    var letterRows: [LetterRow] {
        return GameStore.shared.game.letterBoard.letterRows
    }
    
    var body: some View {
        ZStack() {
            CirclesView()
            LetterRowsView(deleteLetter: deleteLetter, updateWord: updateWord)
                .background(.ultraThinMaterial)
        }
        .clipped()
    }
}

struct LetterBoardView_Previews: PreviewProvider {
    static var previews: some View {
        func noop() {}
        func noop(s: String) {}
        return LetterBoardView(deleteLetter: noop, updateWord: noop)
            .preferredColorScheme(.dark)
            .frame(width: 300, height: 300)
    }
}
