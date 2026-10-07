import XCTest
@testable import SuperHub

final class ModeTests: XCTestCase {
    func testModeIdentifiers() async {
        await MainActor.run {
            XCTAssertEqual(AppMode.familyHub.accessibilityIdentifier, "mode.familyHub")
            XCTAssertEqual(AppMode.botLife.accessibilityIdentifier, "mode.botLife")
            XCTAssertEqual(AppMode.familyHub.title, "Family Hub")
            XCTAssertEqual(AppMode.botLife.title, "Bot Life")
        }
    }
}
