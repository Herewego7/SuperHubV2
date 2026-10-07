import XCTest
@testable import SuperHub

final class BotLifeWindowTests: XCTestCase {
    func testLaunchScreenOpensChat() async {
        let launch = LaunchOptions(
            pinnedDate: "2026-04-01T09:41", screen: "chat", reset: true, skipOnboarding: true,
            forceOnboarding: false, instantChat: true, forceDemo: true
        )
        await MainActor.run {
            let session = BotLifeHost.makeSession(launch: launch)
            BotLifeWindow.applyLaunchScreen(router: session.router, model: session.model)
            XCTAssertEqual(session.router.tab, .chat)
        }
    }

    func testColorSchemeFollowsAppearance() async {
        let launch = LaunchOptions(
            pinnedDate: nil, screen: nil, reset: true, skipOnboarding: true,
            forceOnboarding: false, instantChat: true, forceDemo: true
        )
        await MainActor.run {
            let model = BotLifeHost.makeSession(launch: launch).model
            model.appearance = .dark
            XCTAssertEqual(BotLifeWindow.colorScheme(for: model), .dark)
            model.appearance = .light
            XCTAssertEqual(BotLifeWindow.colorScheme(for: model), .light)
            model.appearance = .system
            XCTAssertNil(BotLifeWindow.colorScheme(for: model))
        }
    }
}
