import Swinject
import UIKit

class OnboardingCoordinator {
    private let container: Container
    private let onboardingPageCountProvider: OnboardingPageCountProvider
    private let coordinatorBuilder: CoordinatorBuilder

    init(
        container: Container,
        onboardingPageCountProvider: OnboardingPageCountProvider,
        coordinatorBuilder: CoordinatorBuilder
    ) {
        self.container = container
        self.onboardingPageCountProvider = onboardingPageCountProvider
        self.coordinatorBuilder = coordinatorBuilder
    }

    private var rootNavigationController: UINavigationController!

    func inject(rootNavigationController: UINavigationController) {
        self.rootNavigationController = rootNavigationController
    }

    private var page = 1

}

extension OnboardingCoordinator: Coordinator {
    func start(animated: Bool) {
        let viewController: OnboardingViewController = container.autoResolve()
        viewController.setPage(page)
        rootNavigationController.setViewControllers([viewController], animated: animated)
    }
}

extension OnboardingCoordinator {
    func goToNextScreen() {
        page += 1

        if page > onboardingPageCountProvider.getPagesCount() {
            coordinatorBuilder.buildTabBarCoordinator(rootNavigationController: rootNavigationController)
                .start(animated: true)
            AppData.onboardingPassed = true
        } else {
            start(animated: true)
        }
    }
}
