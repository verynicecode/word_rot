import SwiftUI

struct RulesScreen: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            HStack() {
                Text("Rules")
                    .font(.futura(30))
                Spacer()
                RottenButton("done", action: handleDonePress)
            }
            Text("Use the letter tiles to make words - one point per letter. Unplayed tiles decay one level each turn. When they decay past the final level then they turn black and are out of play. Insulated tiles don't decay even if they haven't been played that turn. Played tiles insulate their neighbors. The edges of the board also insulate. Unplayed tiles that are not insulated also change their letter after each turn.")
            Spacer()
        }
        .padding(20)
        .navigationBarHidden(true)
    }
    
    func handleDonePress() {
        dismiss()
    }
}

struct RulesScreen_Previews: PreviewProvider {
    static var previews: some View {
        RulesScreen()
    }
}
