import SwiftUI

struct LetterBoardView: View {
    let deleteLetter: () -> Void
    let updateWord: (String) -> Void
    
    var letterRows: [[Tile]] {
        return GameStore.shared.game.tiles.chunked(into: 5)
    }
    
    var body: some View {
        ZStack() {
            CirclesView()
            VStack(spacing: 0) {
                ForEach(letterRows.indices, id: \.self) { index in
                    HStack(spacing: 0) {
                        ForEach(letterRows[index]) { tile in
                            LetterTileView(tile: tile, deleteLetter: deleteLetter, updateWord: updateWord)
                        }
                    }
                }
            }
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
