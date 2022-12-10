import Combine
import MapKit

class DiscoverPresenter {

    private let coordinator: DiscoverCoordinator
    private let openMapClient: OpenMapClient

    init(
        coordinator: DiscoverCoordinator,
        openMapClient: OpenMapClient
    ) {
        self.coordinator = coordinator
        self.openMapClient = openMapClient
    }

    unowned private var view: DiscoverViewController!

    func inject(view: DiscoverViewController) {
        self.view = view

        bind()
    }

    private var bag: Set<AnyCancellable> = .init()

    private func bind() {
        view.currentRegionSubject
            .throttle(for: 3, scheduler: RunLoop.main, latest: true)
            .sink { [weak self] region in
                let radius = region.span.latitudeDelta * 111 * 1000 * 2
                self?.requstPlaces(
                    longitude: region.center.longitude,
                    latitude: region.center.latitude,
                    radius: radius
                )
            }
            .store(in: &bag)
    }

    private func requstPlaces(longitude: Double, latitude: Double, radius: Double) {
        Task {
            do {
                let places = try await openMapClient.fetchPlaces(
                    longitude: longitude,
                    latitude: latitude,
                    radius: radius,
                    kinds: nil,
                    limit: Int(radius / 100)
                )
                await view.displayPlacse(places)
            } catch {
                print(error)
            }
        }
    }
}

extension DiscoverPresenter {
    func navigateToPlaceInfo(xid: String) {
        coordinator.navigateToPlaceInfo(xid: xid)
    }

    func openFilters() {
        coordinator.openFilters()
    }
}
