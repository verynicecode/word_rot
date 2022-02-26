import SwiftUI

struct LetterRowView: View {
    let letterRow: LetterRow
    let updateWord: (String) -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(letterRow.letterTiles) { letterTile in
                LetterTileView(letterTile: letterTile, updateWord: updateWord)
            }
        }
    }
}

//struct LetterRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        LetterRowView()
//    }
//}
