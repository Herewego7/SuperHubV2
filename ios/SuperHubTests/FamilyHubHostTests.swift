import XCTest
import SuperHubFamily

final class FamilyHubHostTests: XCTestCase {
    func testChildControllerIsTheCapacitorBridge() {
        XCTAssertTrue(NSStringFromClass(FamilyHubHost.controllerType).contains("ViewController"))
    }
}
