import XCTest

final class ModeSwitchUITests: XCTestCase {
    func testBotLifeShowsPlan() {
        let app = XCUIApplication()
        app.launchArguments = ["-BLDemo", "-BLSkipOnboarding"]
        app.launch()

        let botLife = labeled("Bot Life", identifier: "mode.botLife", in: app)
        XCTAssertTrue(botLife.waitForExistence(timeout: 20), app.debugDescription)
        botLife.tap()

        let plan = labeled("Plan", identifier: "Plan", in: app)
        XCTAssertTrue(plan.waitForExistence(timeout: 20), app.debugDescription)
        XCTAssertTrue(labeled("Upcoming", identifier: "Upcoming", in: app).exists)
        XCTAssertTrue(labeled("Chat", identifier: "Chat", in: app).exists)
        XCTAssertTrue(labeled("Family", identifier: "Family", in: app).exists)
    }

    private func labeled(_ label: String, identifier: String, in app: XCUIApplication) -> XCUIElement {
        let predicate = NSPredicate(format: "identifier == %@ OR label == %@", identifier, label)
        return app.descendants(matching: .any).matching(predicate).firstMatch
    }
}
