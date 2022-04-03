import SwiftUI

struct LetterRowView: View {
    let letterRow: LetterRow
    let deleteLetter: () -> Void
    let updateWord: (String) -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(letterRow.tiles) { tile in
                LetterTileView(tile: tile, deleteLetter: deleteLetter, updateWord: updateWord)
            }
        }
    }
}

//struct LetterRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        LetterRowView()
//    }
//}
