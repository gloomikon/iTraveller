// swiftlint:disable function_body_length

import Analytics
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

        // MARK: - Core

        container.register(Container.self) { _ in Assembly.shared.container }
        container.autoregister(CoordinatorBuilder.self, initializer: CoordinatorBuilder.init)
        container.autoregister(AppCoordinator.self, initializer: AppCoordinator.init)
        container.autoregister(TabBarCoordinator.self, initializer: TabBarCoordinator.init)
        container.autoregister(OpenMapClient.self, initializer: OpenMapClient.init)

        // MARK: - Onboarding

        container.autoregister(OnboardingInfoProvider.self, initializer: OnboardingInfoProvider.init)
        container.autoregister(OnboardingCoordinator.self, initializer: OnboardingCoordinator.init)
            .inObjectScope(.container)

        container.autoregister(OnboardingPresenter.self, initializer: OnboardingPresenter.init)
            .initCompleted { resolver, presenter in
                presenter.inject(
                    view: resolver.autoResolve(),
                    coordinator: resolver.autoResolve()
                )
            }
        container.autoregister(OnboardingViewController.self, initializer: OnboardingViewController.init(presenter:))
        container.autoregister(OnboardingPageCountProvider.self, initializer: OnboardingPageCountProvider.init)

        // MARK: - Discover

        container.autoregister(DiscoverCoordinator.self, initializer: DiscoverCoordinator.init)
            .inObjectScope(.container)
        container.autoregister(DiscoverViewController.self, initializer: DiscoverViewController.init)
        container.autoregister(DiscoverPresenter.self, initializer: DiscoverPresenter.init)
            .initCompleted { resolver, presenter in
                presenter.inject(
                    view: resolver.autoResolve()
                )
            }

        // MARK: - Filters

        container.autoregister(FilterCoordinator.self, initializer: FilterCoordinator.init)
            .inObjectScope(.container)
        container.autoregister(FilterViewController.self, initializer: FilterViewController.init)
        container.autoregister(FilterPresenter.self, initializer: FilterPresenter.init)
            .initCompleted { resolver, presenter in
                presenter.inject(
                    view: resolver.autoResolve()
                )
            }

        // MARK: - Place Info

        container.autoregister(PlaceInfoCoordinator.self, initializer: PlaceInfoCoordinator.init)
            .inObjectScope(.container)
        container.autoregister(PlaceInfoViewController.self, initializer: PlaceInfoViewController.init)
        container.autoregister(PlaceInfoPresenter.self, initializer: PlaceInfoPresenter.init)
            .initCompleted { resolver, presenter in
                presenter.inject(
                    view: resolver.autoResolve()
                )
            }

        // MARK: - Route

        container.autoregister(RouteCoordinator.self, initializer: RouteCoordinator.init)
            .inObjectScope(.container)
        container.autoregister(RouteServicesProvider.self, initializer: RouteServicesProvider.init)
        container.autoregister(RouteViewContoller.self, initializer: RouteViewContoller.init)
        container.autoregister(RoutePresenter.self, initializer: RoutePresenter.init)
            .initCompleted { resolver, presenter in
                presenter.inject(
                    view: resolver.autoResolve()
                )
            }

        // MARK: - Favorites

        container.autoregister(FavoritesCoordinator.self, initializer: FavoritesCoordinator.init)
            .inObjectScope(.container)

        // MARK: - Services
        container.autoregister(AnalyticsService.self, initializer: AnalyticsService.init)
        container.autoregister(Analytics.AnalyticsService.self, initializer: Analytics.AnalyticsService.init)
        container.autoregister(FavoritesProvider.self, initializer: FavoritesProvider.init)

        // MARK: - Target specific

        finishDependenciesRegistration(for: container)
    }
}
