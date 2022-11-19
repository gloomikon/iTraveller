import Swinject
import UIKit

class CoordinatorBuilder {
    let container: Container

    init(container: Container) {
        self.container = container
    }

    func buildAppCoordinator(window: UIWindow) -> AppCoordinator {
        let coordinator: AppCoordinator = container.autoResolve()
        coordinator.inject(window: window)
        return coordinator
    }

    func buildOnboardingCoordinator(rootNavigationController: UINavigationController) -> OnboardingCoordinator {
        let coordinator: OnboardingCoordinator = container.autoResolve()
        coordinator.inject(rootNavigationController: rootNavigationController)
        return coordinator
    }

    func buildTabBarCoordinator(rootNavigationController: UINavigationController) -> TabBarCoordinator {
        let coordinator: TabBarCoordinator = container.autoResolve()
        coordinator.inject(rootNavigationController: rootNavigationController)
        return coordinator
    }

    func buildDiscroverCoordinator(
        rootNavigationController: UINavigationController,
        tabBarController: TabBarController
    ) -> DiscoverCoordinator {
        let coordinator: DiscoverCoordinator = container.autoResolve()
        coordinator.inject(
            rootNavigationController: rootNavigationController,
            tabBarController: tabBarController
        )
        return coordinator
    }

    func buildRouteCoordinator(
        rootNavigationController: UINavigationController,
        tabBarController: TabBarController
    ) -> RouteCoordinator {
        let coordinator: RouteCoordinator = container.autoResolve()
        coordinator.inject(
            rootNavigationController: rootNavigationController,
            tabBarController: tabBarController
        )
        return coordinator
    }

    func buildFavoritesCoordinator(
        rootNavigationController: UINavigationController,
        tabBarController: TabBarController
    ) -> FavoritesCoordinator {
        let coordinator: FavoritesCoordinator = container.autoResolve()
        coordinator.inject(
            rootNavigationController: rootNavigationController,
            tabBarController: tabBarController
        )
        return coordinator
    }

    func buildPlaceInfoCoordinator(
        rootNavigationController: UINavigationController
    ) -> PlaceInfoCoordinator {
        let coordinator: PlaceInfoCoordinator = container.autoResolve()
        coordinator.inject(
            rootNavigationController: rootNavigationController
        )
        return coordinator
    }
}
