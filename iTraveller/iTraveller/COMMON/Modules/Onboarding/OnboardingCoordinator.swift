import Swinject
import UIKit

class OnboardingCoordinator {
    unowned var rootNavigationContoller: UINavigationController!
    private let container: Container
    private let onboardingPageCountProvider: OnboardingPageCountProvider

    private var page = 1

    init(
        container: Container,
        onboardingPageCountProvider: OnboardingPageCountProvider
    ) {
        self.container = container
        self.onboardingPageCountProvider = onboardingPageCountProvider
    }

}

extension OnboardingCoordinator: Coordinator {
    func start(animated: Bool) {
        let viewController: OnboardingViewController = container.autoResolve()
        viewController.setPage(page)
        rootNavigationContoller.setViewControllers([viewController], animated: animated)
    }
}

extension OnboardingCoordinator {
    func goToNextScreen() {
        page += 1

        if page > onboardingPageCountProvider.getPagesCount() {
            print("finish onboarding")
            AppData.onboardingPassed = true
        } else {
            start(animated: true)
        }
    }
}
