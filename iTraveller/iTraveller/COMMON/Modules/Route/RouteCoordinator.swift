import Swinject
import UIKit

class RouteCoordinator {
    let container: Container

    init(container: Container) {
        self.container = container
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

extension RouteCoordinator: Coordinator {
    func start(animated: Bool) {
        let viewController: RouteViewContoller = container.autoResolve()
        viewController.title = "Route"

        let navController = NavigationController(rootViewController: viewController)

        let name = "arrow.triangle.swap"
        let tabBarItem = UITabBarItem(
            title: "Route",
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
