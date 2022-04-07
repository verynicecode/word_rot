import SwiftUI

let rotToOpacity = [
    0: 0.9,
    1: 0.7,
    2: 0.6,
    3: 0.4,
    4: 0.2
]

struct LetterTileView: View {
    @ObservedObject var tile: Tile
    
    var opacity: CGFloat {
        guard
            !tile.racked,
            let opacity = rotToOpacity[tile.rotLevel]
        else { return 1.0 }
        
        return opacity
    }
    
    var body: some View {
        let backgroundColor = tile.rotLevel == 5 ? Color.black : Color.white.opacity(opacity)
        let letterLabel = tile.rotLevel == 5 ? "" : tile.letter.uppercased()
        
        Button(action: handlePress) {
            Text(letterLabel)
                .font(.futura(40))
                .foregroundColor(Color.white)
                .shadow(color: Color.black, radius: 8)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(backgroundColor)
        }
    }
    
    func handlePress() {
        if tile.racked {
            GameStore.shared.unrack(tile: tile)
        } else {
            GameStore.shared.rack(tile: tile)
        }
    }
}

struct LetterTileView_Previews: PreviewProvider {
    static var previews: some View {
        let decomps = (0...5)
        
        VStack(spacing: 0) {
            ForEach(decomps, id: \.self) { decomp in
                LetterTileView(tile: Tile(record: TileRecord(
                    id: 1,
                    gameId: 1,
                    row: 1,
                    column: 1,
                    letter: "a",
                    decomp: decomp,
                    rackPosition: nil
                )))
            }
        }
        .preferredColorScheme(.dark)
        .previewLayout(.fixed(width: 60, height: CGFloat((decomps.count * 60))  ))
    }
}
