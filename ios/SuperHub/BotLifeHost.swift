import SwiftUI

enum BotLifeHost {
    static func makeSession(launch: LaunchOptions = .current) -> (model: AppModel, router: Router) {
        let model = AppModel(launch: launch, backend: Backend.configure(launch))
        let router = Router()
        NotificationManager.shared.configure(model: model, router: router)
        return (model, router)
    }
}
