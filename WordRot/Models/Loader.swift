import Foundation
import SQLite

struct Loader {
    static func check(pass passCallback: () -> Void, fail failCallback: () -> Void) {
        databaseStuff()
        killswitchStuff(pass: passCallback, fail: failCallback)
    }
    
    static func killswitchStuff(pass passCallback: () -> Void, fail failCallback: () -> Void) {
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
    
    static func databaseStuff() {
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let destinationPath = documentsUrl.appendingPathComponent("rotten.sqlite3").path
        
        guard !FileManager.default.fileExists(atPath: destinationPath) else { return }
        
        do {
            let sourcePath = Bundle.main.path(forResource: "rotten.sqlite3", ofType: nil)!
            try FileManager.default.copyItem(atPath: sourcePath, toPath: destinationPath)
        } catch {
            print("error during file copy: \(error)")
        }
    }
}
