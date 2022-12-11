import Swinject
import UIKit

class BasePlaceInfoCoordinator {
    let container: Container

    init(container: Container) {
        self.container = container
    }

    var rootNavigationController: UINavigationController!
    var xid: String?
    var placeInfo: PlaceInfo?

    func inject(
        rootNavigationController: UINavigationController,
        xid: String?,
        placeInfo: PlaceInfo?
    ) {
        self.rootNavigationController = rootNavigationController
        self.xid = xid
        self.placeInfo = placeInfo
    }
}

extension CoordinatorTemplate where Self: BasePlaceInfoCoordinator {
    func createModule() -> UIViewController {
        let viewController: PlaceInfoViewController = container.autoResolve()
        if let xid {
            viewController.set(xid)
        } else if let placeInfo {
            viewController.set(placeInfo)
        }
        return viewController
    }
}
