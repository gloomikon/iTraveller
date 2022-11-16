import Swinject
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let container = makeContainer()
        registerDependencies(for: container)

        let window = UIWindow(windowScene: windowScene)
        setupCoordinator(with: window)
            .start(animated: true)
        self.window = window
    }

    private func setupCoordinator(with window: UIWindow) -> Coordinator {
        let coordinatorBuilder: CoordinatorBuilder = Assembly.shared.container.autoResolve()
        let coordinator = coordinatorBuilder.buildAppCoordinator(window: window)

        return coordinator
    }
}
