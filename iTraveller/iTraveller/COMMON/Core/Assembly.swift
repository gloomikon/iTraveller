import Swinject
import SwinjectAutoregistration

class Assembly {

    static let shared = Assembly()

    var container: Container!

    private init() { }
}

extension SceneDelegate {

    func makeContainer() -> Container {
        let container = Container()
        Assembly.shared.container = container

        return container
    }

    func registerDependencies(for container: Container) {
        container.register(Container.self) { _ in Assembly.shared.container }
        container.autoregister(CoordinatorBuilder.self, initializer: CoordinatorBuilder.init)
        container.autoregister(AppCoordinator.self, initializer: AppCoordinator.init)
        container.autoregister(OnboardingInfoProvider.self, initializer: OnboardingInfoProvider.init)
        container.autoregister(OnboardingCoordinator.self, initializer: OnboardingCoordinator.init)
            .inObjectScope(.container)

        container.register(OnboardingPresenter.self) { resolver in
            let onboardingInfoProvider = resolver ~> OnboardingInfoProvider.self

            return OnboardingPresenter(onboardingInfoProvider: onboardingInfoProvider)
        }.initCompleted { resolver, presenter in
            let view = resolver ~> OnboardingViewController.self
            let coordinator = resolver ~> OnboardingCoordinator.self

            presenter.inject(
                view: view,
                coordinator: coordinator
            )
        }

        container.autoregister(OnboardingViewController.self, initializer: OnboardingViewController.init(presenter:))
        container.autoregister(OnboardingPageCountProvider.self, initializer: OnboardingPageCountProvider.init)
        container.autoregister(TabBarCoordinator.self, initializer: TabBarCoordinator.init)
        container.autoregister(DiscoverCoordinator.self, initializer: DiscoverCoordinator.init)
        container.autoregister(RouteCoordinator.self, initializer: RouteCoordinator.init)
        container.autoregister(FavoritesCoordinator.self, initializer: FavoritesCoordinator.init)

        finishDependenciesRegistration(for: container)
    }
}
