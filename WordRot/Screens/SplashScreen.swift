import SwiftUI

struct SplashScreen: View {
    var body: some View {
        ZStack {
            Color.black
            Text("loading...")
                .foregroundColor(Color.complete)
                .font(Font.futura(40))
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
            .preferredColorScheme(.dark)
    }
}
