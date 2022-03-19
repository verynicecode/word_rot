import SwiftUI

struct Loader {
    static func check(pass passCallback: () -> Void, fail failCallback: () -> Void) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let endpoint = "https://wordrot-production.herokuapp.com/api/v1/killswitch.json"
        
        guard
            let killswitchUrl = URL(string: endpoint),
            let data = try? Data(contentsOf: killswitchUrl),
            let killswitch = try? decoder.decode(Killswitch.self, from: data)
        else { return }
        
        let buildVersion = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
        let buildNumber = Int(buildVersion)!
                
        let callback = killswitch.verify(buildNumber) ? passCallback : failCallback
        callback()
    }
}

struct Killswitch: Codable {
    let badBuilds: [Int]
    let minimumBuild: Int
    
    func verify(_ buildNumber: Int) -> Bool {
        let goodBuild = !badBuilds.contains(buildNumber)
        let atLeastMinimumBuild = buildNumber >= minimumBuild
        
        return goodBuild && atLeastMinimumBuild
    }
}

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
