import SwiftUI
import UIKit

public struct FamilyHubScreen: UIViewControllerRepresentable {
    public init() {}

    public func makeUIViewController(context: Context) -> UIViewController {
        ViewController()
    }

    public func updateUIViewController(_ controller: UIViewController, context: Context) {}
}

public enum FamilyHubHost {
    public static let controllerType: UIViewController.Type = ViewController.self
}
