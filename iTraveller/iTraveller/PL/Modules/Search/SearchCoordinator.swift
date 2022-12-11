import Swinject
import UIKit

class SearchCoordinator {

    private let container: Container

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

extension SearchCoordinator: Coordinator {
    func start(animated: Bool) {
        let viewController: SearchViewController = container.autoResolve()
        viewController.title = "Search"

        let navController = NavigationController(rootViewController: viewController)

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
