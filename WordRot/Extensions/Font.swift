import SwiftUI

let futuraFontName = "Futura-Medium"

extension Font {
    static func futura(_ size: CGFloat) -> Font {
        return Font.custom(futuraFontName, size: size)
    }
}
