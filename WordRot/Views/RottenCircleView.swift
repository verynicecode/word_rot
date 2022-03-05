import SwiftUI

struct RottenCircleView: View {
    @State private var animationFlag = true
    
    let color: Color
    let duration: Double
    let width: CGFloat
    let start: (CGFloat, CGFloat)
    let end: (CGFloat, CGFloat)
    
    init(_ color: Color, duration: Double, width: CGFloat, start: (CGFloat, CGFloat), end: (CGFloat, CGFloat)) {
        self.color = color
        self.duration = duration
        self.width = width
        self.start = start
        self.end = end
    }
    
    var body: some View {
        let animation = Animation.easeInOut(duration: duration)
            .repeatForever(autoreverses: true)
        
        let offset = animationFlag ? start : end
        
        Circle()
            .fill(color)
            .frame(width: width)
            .offset(x: offset.0, y: offset.1)
            .animation(animation, value: animationFlag)
            .onAppear {
                animationFlag.toggle()
            }
    }
}
