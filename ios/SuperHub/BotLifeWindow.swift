import SwiftUI
import GoogleSignIn
import BotLifeCore
import BotLifeDesign

struct BotLifeWindow: View {
    @Bindable var model: AppModel
    var router: Router
    @Environment(\.scenePhase) private var scenePhase

    var body: some View {
        RootView()
            .environment(model)
            .environment(router)
            .preferredColorScheme(Self.colorScheme(for: model))
            .tint(Palette.brand)
            .onOpenURL { url in
                if GIDSignIn.sharedInstance.handle(url) { return }
                if let link = DeepLink(url: url) { router.open(link, model: model) }
            }
            .task { Self.applyLaunchScreen(router: router, model: model) }
            .task {
                while !Task.isCancelled {
                    try? await Task.sleep(for: .seconds(30))
                    model.advanceClock()
                }
            }
            .onChange(of: scenePhase) { _, phase in
                switch phase {
                case .active:
                    model.advanceClock()
                    model.importSharedCaptures()
                    model.phoneCalendarsBecameActive()
                case .background:
                    if model.currentUser?.appLock == true { model.isLocked = true }
                    model.exportForExtensions()
                    if model.hasPhoneCalendars { BackgroundRefresh.schedule() }
                default:
                    break
                }
            }
    }

    static func colorScheme(for model: AppModel) -> ColorScheme? {
        model.appearance.colorScheme
    }

    static func applyLaunchScreen(router: Router, model: AppModel) {
        guard let screen = model.launch.screen else { return }
        router.openLaunchScreen(screen, model: model)
    }
}
