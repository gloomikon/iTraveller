import Swinject
import UIKit

class FavoritesCoordinator {
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

    private var favoritesNavigationController: UINavigationController?
}

extension FavoritesCoordinator: Coordinator {
    func start(animated: Bool) {
        let viewController: FavoritesViewController = container.autoResolve()
        viewController.title = "Favorites"

        let navController = NavigationController(rootViewController: viewController)
        favoritesNavigationController = navController
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

extension FavoritesCoordinator {
    func openPlaceInfo(_ placeInfo: PlaceInfo) {
        guard let favoritesNavigationController else { return }
        coordinatorBuilder.buildPlaceInfoCoordinator(
            rootNavigationController: favoritesNavigationController,
            xid: nil,
            placeInfo: placeInfo
        )
        .start(animated: true)
    }
}
