import UIKit

extension CoordinatorBuilder {
    func buildSearchCoordinator(
        rootNavigationController: UINavigationController,
        tabBarController: TabBarController
    ) -> SearchCoordinator {
        let coordinator: SearchCoordinator = container.autoResolve()
        coordinator.inject(
            rootNavigationController: rootNavigationController,
            tabBarController: tabBarController
        )
        return coordinator
    }
}
