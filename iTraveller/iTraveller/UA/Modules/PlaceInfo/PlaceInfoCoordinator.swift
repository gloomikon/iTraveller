import UIKit

class PlaceInfoCoordinator: BasePlaceInfoCoordinator { }

extension PlaceInfoCoordinator: CoordinatorTemplate {
    func displayModule(with viewController: UIViewController, animated: Bool) {
        rootNavigationController.present(viewController, animated: animated)
    }
}
