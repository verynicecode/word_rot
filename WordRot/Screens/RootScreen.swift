import SwiftUI

struct RootScreen: View {
    @State private var isLoading = true
    @State private var showPrompt = false
    
    var body: some View {
        ZStack {
            TitleScreen(store: GameStore.shared)
            SplashScreen()
                .opacity(isLoading ? 1 : 0)
                .task {
                    beginLoading()
                }
                .alert(isPresented: $showPrompt) {
                    Alert(
                        title: Text("Please Update!"),
                        message: Text("There is a problem with this version."),
                        dismissButton: .default(Text("OK"))
                    )
                }
        }
    }
    
    func beginLoading() {
        Loader.check(pass: finishLoading, fail: promptToUpdate)
    }
    
    func finishLoading() {
        withAnimation {
            isLoading = false
        }
    }
    
    func promptToUpdate() {
        showPrompt = true
    }
}

struct RootScreen_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
            .preferredColorScheme(.dark)
    }
}
