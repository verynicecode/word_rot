import SwiftUI

let rotToOpacity = [
    0: 0.9,
    1: 0.7,
    2: 0.6,
    3: 0.4,
    4: 0.2,
    5: 0.1
]

struct LetterTileView: View {
    @State private var animateGradient = false
    @ObservedObject var letterTile: LetterTile
    
    let deleteLetter: () -> Void
    let updateWord: (String) -> Void
    
    var opacity: CGFloat {
        guard
            !letterTile.racked,
            let opacity = rotToOpacity[letterTile.rotLevel]
        else { return 1.0 }
        
        return opacity
    }
    
    var body: some View {
        let backgroundColor = Color.white.opacity(opacity)
        
        Button(action: handlePress) {
            Text(letterTile.letter.uppercased())
                .font(.custom("Futura-Medium", size: 40))
                .foregroundColor(Color.white)
                .shadow(color: Color.black, radius: 8)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(backgroundColor)
        }
    }
    
    func handlePress() {
        if letterTile.racked {
            deleteLetter()
        } else {
            GameStore.shared.currentGame.letterBoard.rackLetter(letterTile: letterTile)
            updateWord(letterTile.letter)
        }
        
        letterTile.update()
    }
}

//struct LetterTileView_Previews: PreviewProvider {
//    static var previews: some View {
//        LetterTileView()
//    }
//}
