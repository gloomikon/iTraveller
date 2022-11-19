import Swinject
import UIKit

class BasePlaceInfoCoordinator {
    let container: Container

    init(container: Container) {
        self.container = container
    }

    var rootNavigationController: UINavigationController!
    var xid: String!

    func inject(
        rootNavigationController: UINavigationController,
        xid: String
    ) {
        self.rootNavigationController = rootNavigationController
        self.xid = xid
    }
}

extension CoordinatorTemplate where Self: BasePlaceInfoCoordinator {
    func createModule() -> UIViewController {
        let viewController: PlaceInfoViewController = container.autoResolve()
        viewController.set(xid)
        return viewController
    }
}
