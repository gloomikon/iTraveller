import UIKit

class AppCoordinator {

    // MARK: - Injected properties
    private let onboardingCoordinator: OnboardingCoordinator

    init(onboardingCoordinator: OnboardingCoordinator) {
        self.onboardingCoordinator = onboardingCoordinator
    }

    var window: UIWindow!

    // MARK: - Private properties
    private let navigationController = UINavigationController()
}

extension AppCoordinator: Coordinator {
    func start(animated: Bool) {
        window.rootViewController = navigationController
        navigationController.navigationBar.tintColor = .primary800
        window.makeKeyAndVisible()

//        if AppData.onboardingPassed {
        onboardingCoordinator.rootNavigationContoller = navigationController
        onboardingCoordinator.start(animated: animated)
//            coordinatorBuilder.buildNotesListCoordinator(rootNavigationContoller: navigationController)
//                .start(animated: animated)
//        } else {
//            coordinatorBuilder.buildOnboardingCoordinator(rootNavigationContoller: navigationController)
//                .start(animated: animated)
//        }
    }
}
