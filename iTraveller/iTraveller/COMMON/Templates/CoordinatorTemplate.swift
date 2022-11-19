import UIKit

protocol CoordinatorTemplate: Coordinator {
    func createModule() -> UIViewController
    func displayModule(with viewController: UIViewController, animated: Bool)
}

extension CoordinatorTemplate {
    func start(animated: Bool) {
        let viewController = createModule()
        displayModule(with: viewController, animated: animated)
    }
}
