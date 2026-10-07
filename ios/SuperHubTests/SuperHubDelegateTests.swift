import UIKit
import XCTest
@testable import SuperHub

final class SuperHubDelegateTests: XCTestCase {
    func testDeviceTokenReachesBotLifeAndFamilyHub() async {
        let launch = LaunchOptions(
            pinnedDate: nil, screen: nil, reset: true, skipOnboarding: true,
            forceOnboarding: false, instantChat: true, forceDemo: true
        )
        let model = await MainActor.run { BotLifeHost.makeSession(launch: launch).model }
        let token = Data([9, 8, 7])
        let posted = expectation(description: "capacitor token")
        let observer = NotificationCenter.default.addObserver(forName: nil, object: nil, queue: .main) { note in
            if let data = note.object as? Data, data == token {
                posted.fulfill()
            }
        }
        await MainActor.run {
            SuperHubDelegate().application(UIApplication.shared, didRegisterForRemoteNotificationsWithDeviceToken: token)
        }
        await fulfillment(of: [posted], timeout: 2)
        NotificationCenter.default.removeObserver(observer)
        let stored = await MainActor.run { model.pushToken }
        XCTAssertEqual(stored, token)
    }

    func testCalendarRefreshCompletes() async {
        let launch = LaunchOptions(
            pinnedDate: nil, screen: nil, reset: true, skipOnboarding: true,
            forceOnboarding: false, instantChat: true, forceDemo: true
        )
        await MainActor.run { _ = BotLifeHost.makeSession(launch: launch) }
        let done = expectation(description: "fetch completion")
        await MainActor.run {
            SuperHubDelegate().application(
                UIApplication.shared,
                didReceiveRemoteNotification: ["kind": "calendarRefresh"],
                fetchCompletionHandler: { result in
                    XCTAssertEqual(result, .noData)
                    done.fulfill()
                }
            )
        }
        await fulfillment(of: [done], timeout: 2)
    }
}
