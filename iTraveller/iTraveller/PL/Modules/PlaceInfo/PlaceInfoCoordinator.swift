import UIKit

class PlaceInfoCoordinator: BasePlaceInfoCoordinator { }

extension PlaceInfoCoordinator: CoordinatorTemplate {
    func displayModule(with viewController: UIViewController, animated: Bool) {
//        viewController.navigationController?.isNavigationBarHidden = false
        rootNavigationController.pushViewController(viewController, animated: animated)
    }
}
