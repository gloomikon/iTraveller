import UIKit

protocol CoordinatorTemplate: AnyObject {
    func createModule() -> UIViewController
    func displayModule(with viewController: UIViewController, animated: Bool)
}

extension Coordinator where Self: CoordinatorTemplate {
    func start(animated: Bool) {
        let viewController = createModule()
        displayModule(with: viewController, animated: animated)
    }
}
