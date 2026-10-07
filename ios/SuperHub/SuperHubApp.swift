import SwiftUI
import SuperHubFamily

@main
struct SuperHubApp: App {
    @UIApplicationDelegateAdaptor(SuperHubDelegate.self) private var appDelegate
    @State private var mode = AppMode.familyHub
    @State private var model: AppModel
    @State private var router: Router

    init() {
        let session = BotLifeHost.makeSession()
        _model = State(initialValue: session.model)
        _router = State(initialValue: session.router)
    }

    var body: some Scene {
        WindowGroup {
            VStack(spacing: 0) {
                ModeSwitcher(mode: $mode)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                ZStack {
                    FamilyHubScreen()
                        .opacity(mode == .familyHub ? 1 : 0)
                        .allowsHitTesting(mode == .familyHub)
                        .accessibilityHidden(mode != .familyHub)
                    BotLifeWindow(model: model, router: router)
                        .opacity(mode == .botLife ? 1 : 0)
                        .allowsHitTesting(mode == .botLife)
                        .accessibilityHidden(mode != .botLife)
                }
            }
        }
    }
}
