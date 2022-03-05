import SwiftUI

struct CirclesView: View {
    var body: some View {
        Group {
            RottenCircleView(Color.complete, duration: 2.0, width: 50, start: (-100, -100), end: (100, -100))
            RottenCircleView(Color.serious, duration: 13.0, width: 200, start: (-100, 0), end: (-100, 100))
            RottenCircleView(Color.purple, duration: 2.0, width: 200, start: (0, 0), end: (100, 100))
            RottenCircleView(Color.black, duration: 10.0, width: 100, start: (100, 0), end: (-100, 0))
            RottenCircleView(Color.complete, duration: 20.0, width: 100, start: (0, 100), end: (100, 0))
            RottenCircleView(Color.yellow, duration: 10.0, width: 100, start: (100, 100), end: (0, 0))
        }
    }
}
