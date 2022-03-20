import Foundation

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
