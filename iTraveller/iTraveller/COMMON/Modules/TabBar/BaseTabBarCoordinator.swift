import Swinject
import UIKit

protocol TabBarCoordinatorTemplate {
    func makeTabBarController() -> TabBarController
    func makeCoordinators(with tabBarController: TabBarController) -> [Coordinator]
    func startCoordinators(_ coordinators: [Coordinator], animated: Bool)
    func displayTabBarController(_ tabBarController: TabBarController, animated: Bool)
}

extension TabBarCoordinatorTemplate {
    func makeTabBarController() -> TabBarController {
        .init()
    }

    func startCoordinators(_ coordinators: [Coordinator], animated: Bool) {
        coordinators.forEach { $0.start(animated: animated)}
    }
}

extension Coordinator where Self: TabBarCoordinatorTemplate {
    func start(animated: Bool) {
        let tabBarConroller = makeTabBarController()
        let coordinators = makeCoordinators(with: tabBarConroller)
        startCoordinators(coordinators, animated: animated)
        displayTabBarController(tabBarConroller, animated: animated)
    }
}

class BaseTabBarCoordinator {

    let coordinatorBuilder: CoordinatorBuilder

    init(coordinatorBuilder: CoordinatorBuilder) {
        self.coordinatorBuilder = coordinatorBuilder
    }

    var rootNavigationController: UINavigationController!

    func inject(rootNavigationController: UINavigationController) {
        self.rootNavigationController = rootNavigationController
    }
}

extension TabBarCoordinatorTemplate where Self: BaseTabBarCoordinator {
    func displayTabBarController(_ tabBarController: TabBarController, animated: Bool) {
        tabBarController.viewControllers?
            .compactMap { $0 as? UINavigationController }
            .forEach { (navController: UINavigationController) in
                _ = navController.topViewController?.view
            }

        rootNavigationController.setViewControllers([tabBarController], animated: animated)
    }
}
