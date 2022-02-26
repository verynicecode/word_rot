import SwiftUI

struct RottenLink<Destination>: View where Destination: View {
    let text: String
    let destination: Destination
    
    init(_ text: String, destination: Destination) {
        self.text = text
        self.destination = destination
    }
    
    var body: some View {
        NavigationLink(text.uppercased(), destination: destination)
            .padding([.top, .bottom], 6)
            .padding([.leading, .trailing], 12)
            .font(Font.futura(18))
            .foregroundColor(Color.black)
            .background(Color.white)
            .clipShape(Capsule())
    }
}

struct RottenLink_Previews: PreviewProvider {
    static var previews: some View {
        VStack() {
            RottenLink("start", destination: EmptyView())
            RottenLink("quit", destination: EmptyView())
        }
        .preferredColorScheme(.dark)
    }
}
