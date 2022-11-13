import UIKit

class DiscoverCoordinator {
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
        let viewController = UIViewController()
        viewController.title = "Discover"

        let navController = UINavigationController(rootViewController: viewController)

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
