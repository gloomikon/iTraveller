class TabBarCoordinator: BaseTabBarCoordinator, TabBarCoordinatorTemplate {
    func makeCoordinators(with tabBarController: TabBarController) -> [Coordinator] {
        [
            coordinatorBuilder.buildDiscroverCoordinator(
                rootNavigationController: rootNavigationController,
                tabBarController: tabBarController
            ),

            coordinatorBuilder.buildRouteCoordinator(
                rootNavigationController: rootNavigationController,
                tabBarController: tabBarController
            ),

            coordinatorBuilder.buildFavoritesCoordinator(
                rootNavigationController: rootNavigationController,
                tabBarController: tabBarController
            )
        ]
    }
}

extension TabBarCoordinator: Coordinator { }
