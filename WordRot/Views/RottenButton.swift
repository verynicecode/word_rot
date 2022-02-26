//
//  RottenButton.swift
//  WordRot
//
//  Created by Jonathan Allured on 2/26/22.
//

import SwiftUI

struct RottenButton: View {
    let text: String
    let action: () -> Void
    
    init(_ text: String, action: @escaping () -> Void) {
        self.text = text
        self.action = action
    }
    
    var body: some View {
        Button(text.uppercased(), action: action)
            .padding([.top, .bottom], 6)
            .padding([.leading, .trailing], 12)
            .font(Font.futura(18))
            .foregroundColor(Color.black)
            .background(Color.white)
            .clipShape(Capsule())
    }
}

struct RottenButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack() {
            RottenButton("start", action: {})
            RottenButton("quit", action: {})
        }
        .preferredColorScheme(.dark)
    }
}
