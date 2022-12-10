import Swinject
import UIKit

class FilterCoordinator {
    private let container: Container

    init(
        container: Container
    ) {
        self.container = container
    }

    private var rootNavigationController: UINavigationController!

    func inject(
        rootNavigationController: UINavigationController
    ) {
        self.rootNavigationController = rootNavigationController
    }
}

extension FilterCoordinator: Coordinator {
    func start(animated: Bool) {
        let viewController: FilterViewController = container.autoResolve()
        rootNavigationController.present(viewController, animated: animated)
    }
}
