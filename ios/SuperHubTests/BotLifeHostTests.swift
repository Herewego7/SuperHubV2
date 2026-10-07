import XCTest
@testable import SuperHub

final class BotLifeHostTests: XCTestCase {
    func testForceDemoDoesNotOpenFirebase() async {
        let launch = LaunchOptions(
            pinnedDate: nil, screen: nil, reset: true, skipOnboarding: true,
            forceOnboarding: false, instantChat: true, forceDemo: true
        )
        await MainActor.run {
            XCTAssertEqual(Backend.configure(launch), .demo)
        }
    }
}
