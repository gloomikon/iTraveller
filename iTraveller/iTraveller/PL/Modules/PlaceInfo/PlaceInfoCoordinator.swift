import UIKit

class PlaceInfoCoordinator: BasePlaceInfoCoordinator { }

extension PlaceInfoCoordinator: CoordinatorTemplate {
    func displayModule(with viewController: UIViewController, animated: Bool) {
        rootNavigationController.setViewControllers([viewController], animated: animated)
    }
}
