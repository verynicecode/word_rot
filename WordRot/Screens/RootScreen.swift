import SwiftUI

extension UIDevice {
    static let deviceDidShakeNotification = Notification.Name(rawValue: "deviceDidShakeNotification")
}

extension UIWindow {
    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NotificationCenter.default.post(name: UIDevice.deviceDidShakeNotification, object: nil)
        }
    }
}

struct DeviceShakeViewModifier: ViewModifier {
    let action: () -> Void
    
    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.deviceDidShakeNotification)) { _ in
                action()
            }
    }
}

extension View {
    func onShake(perform action: @escaping () -> Void) -> some View {
        self.modifier(DeviceShakeViewModifier(action: action))
    }
}

struct TitleScreen: View {
    var body: some View {
        ZStack {
            Color.red
            Text("TitleScreen")
        }
    }
}

struct SplashScreen: View {
    var body: some View {
        ZStack {
            Color.blue
            Text("SplashScreen")
        }
    }
}

struct DebugScreen: View {
    let dismiss: () -> Void
    
    var body: some View {
        ZStack {
            Color.yellow
            VStack {
                Text("DebugScreen")
                Button("close", action: handleCloseTap)
            }
        }
    }
    
    func handleCloseTap() {
        dismiss()
    }
}

struct RootScreen: View {
    @State var showDebug = false
    
    var body: some View {
        ZStack {
            TitleScreen()
            SplashScreen()
            DebugScreen(dismiss: dismissDebug)
                .opacity(showDebug ? 1 : 0)
                .onShake {
                    self.showDebug = true
                }
        }
    }
    
    func dismissDebug() {
        self.showDebug = false
    }
}

struct RootScreen_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
    }
}
