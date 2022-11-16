import UIKit

class AppCoordinator {

    // MARK: - Injected properties
    private let coordinatorBuilder: CoordinatorBuilder

    init(coordinatorBuilder: CoordinatorBuilder) {
        self.coordinatorBuilder = coordinatorBuilder
    }

    private var window: UIWindow!

    func inject(window: UIWindow) {
        self.window = window
    }

    // MARK: - Private properties
    private let navigationController = UINavigationController()
}

extension AppCoordinator: Coordinator {
    func start(animated: Bool) {
        window.rootViewController = navigationController
        navigationController.navigationBar.tintColor = .primary800
        window.makeKeyAndVisible()
        navigationController.navigationBar.isHidden = true

        if AppData.onboardingPassed {
            coordinatorBuilder.buildTabBarCoordinator(rootNavigationController: navigationController)
                .start(animated: animated)
        } else {
            coordinatorBuilder.buildOnboardingCoordinator(rootNavigationController: navigationController)
                .start(animated: animated)
        }
    }
}
