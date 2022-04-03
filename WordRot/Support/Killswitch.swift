import Foundation

struct Killswitch: Codable {
    let badBuilds: [Int]
    let minimumBuild: Int
    
    func verify(_ buildNumber: Int) -> Bool {
        let goodBuild = !badBuilds.contains(buildNumber)
        let atLeastMinimumBuild = buildNumber >= minimumBuild
        
        return goodBuild && atLeastMinimumBuild
    }
}
