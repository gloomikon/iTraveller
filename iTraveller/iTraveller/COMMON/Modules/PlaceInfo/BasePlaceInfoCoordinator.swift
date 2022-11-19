import Swinject
import UIKit

class BasePlaceInfoCoordinator {
    let container: Container

    init(container: Container) {
        self.container = container
    }

    var rootNavigationController: UINavigationController!

    func inject(rootNavigationController: UINavigationController) {
        self.rootNavigationController = rootNavigationController
    }
}

extension CoordinatorTemplate where Self: BasePlaceInfoCoordinator {
    func createModule() -> UIViewController {
        let viewController: PlaceInfoViewController = container.autoResolve()
        return viewController
    }
}
