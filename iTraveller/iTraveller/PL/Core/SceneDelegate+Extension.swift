import Swinject
import UIKit

extension SceneDelegate {
    func finishDependenciesRegistration(for container: Container) {
        container.autoregister(SearchCoordinator.self, initializer: SearchCoordinator.init)
    }
}
