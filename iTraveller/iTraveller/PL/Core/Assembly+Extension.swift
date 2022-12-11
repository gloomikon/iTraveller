import Swinject
import UIKit

extension SceneDelegate {
    func finishDependenciesRegistration(for container: Container) {

        // MARK: - Search
        container.autoregister(SearchCoordinator.self, initializer: SearchCoordinator.init)
            .inObjectScope(.container)
        container.autoregister(SearchViewController.self, initializer: SearchViewController.init)
        container.autoregister(SearchPresenter.self, initializer: SearchPresenter.init)
            .initCompleted { resolver, presenter in
                presenter.inject(
                    view: resolver.autoResolve()
                )
            }
    }
}
