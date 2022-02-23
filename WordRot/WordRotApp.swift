//
//  WordRotApp.swift
//  WordRot
//
//  Created by Jonathan Allured on 1/28/22.
//

import SwiftUI

@main
struct WordRotApp: App {
    var body: some Scene {
        WindowGroup {
            TitleView(store: GameStore.shared)
                .preferredColorScheme(.light)
        }
    }
}
