import UIKit

class FavoritesCoordinator {
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

extension FavoritesCoordinator: Coordinator {
    func start(animated: Bool) {
        let viewController = UIViewController()
        viewController.title = "Favorites"

        let navController = NavigationController(rootViewController: viewController)

        let tabBarItem = UITabBarItem(
            title: "Favorites",
            image: .init(systemName: "heart"),
            selectedImage: .init(systemName: "heart.fill")
        )

        navController.tabBarItem = tabBarItem

        if tabBarController.viewControllers == nil {
            tabBarController.viewControllers = [navController]
        } else {
            tabBarController.viewControllers?.append(navController)
        }
    }
}
