import Swinject
import UIKit

class DiscoverCoordinator {

    private let container: Container
    private let coordinatorBuilder: CoordinatorBuilder

    init(
        container: Container,
        coordinatorBuilder: CoordinatorBuilder
    ) {
        self.container = container
        self.coordinatorBuilder = coordinatorBuilder
    }

    private var rootNavigationController: UINavigationController!
    private var tabBarController: TabBarController!

    func inject(
        rootNavigationController: UINavigationController,
        tabBarController: TabBarController
    ) {
        self.rootNavigationController = rootNavigationController
        self.tabBarController = tabBarController
    }
}

extension DiscoverCoordinator: Coordinator {
    func start(animated: Bool) {
        let viewController: DiscoverViewController = container.autoResolve()
        viewController.title = "Discover"

        let navController = NavigationController(rootViewController: viewController)

        let name = "globe"
        let tabBarItem = UITabBarItem(
            title: "Discrover",
            image: .init(systemName: name),
            selectedImage: .init(systemName: name)
        )

        navController.tabBarItem = tabBarItem

        if tabBarController.viewControllers == nil {
            tabBarController.viewControllers = [navController]
        } else {
            tabBarController.viewControllers?.append(navController)
        }
    }
}

extension DiscoverCoordinator {
    func navigateToPlaceInfo(xid: String) {
        coordinatorBuilder.buildPlaceInfoCoordinator(
            rootNavigationController: rootNavigationController
        )
        .start(animated: true)
    }
}
