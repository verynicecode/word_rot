import Foundation
import SQLite

struct Loader {
    static func check(pass passCallback: @escaping () -> Void, fail failCallback: @escaping () -> Void) {
        RottenDB.ensureDatabaseFile()
        killswitchStuff(pass: passCallback, fail: failCallback)
    }
    
    static func killswitchStuff(pass passCallback: @escaping () -> Void, fail failCallback: @escaping () -> Void) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let endpoint = "https://app.jonallured.com/api/v1/word_rot/killswitch.json"
        
        guard
            let killswitchUrl = URL(string: endpoint),
            let data = try? Data(contentsOf: killswitchUrl),
            let killswitch = try? decoder.decode(Killswitch.self, from: data)
        else {
            DispatchQueue.main.async {
                passCallback()
            }
            
            return
        }
        
        let buildVersion = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
        let buildNumber = Int(buildVersion)!
        
        let callback = killswitch.verify(buildNumber) ? passCallback : failCallback
        
        DispatchQueue.main.async {
            callback()
        }
    }
}
