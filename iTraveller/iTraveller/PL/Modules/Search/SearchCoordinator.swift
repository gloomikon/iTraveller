import UIKit

class SearchCoordinator {
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

extension SearchCoordinator: Coordinator {
    func start(animated: Bool) {
        let viewController = UIViewController()
        viewController.title = "Search"

        let navController = UINavigationController(rootViewController: viewController)

        let name = "magnifyingglass"
        let tabBarItem = UITabBarItem(
            title: "Search",
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
