import Combine
import MapKit

class DiscoverPresenter {

    private let openMapClient: OpenMapClient

    init(openMapClient: OpenMapClient) {
        self.openMapClient = openMapClient
    }

    unowned private var view: DiscoverViewController!

    func inject(view: DiscoverViewController) {
        self.view = view

        bind()
    }

    private var bag: Set<AnyCancellable> = .init()

    func bind() {
        view.currentRegionSubject
            .throttle(for: 3, scheduler: RunLoop.main, latest: true)
            .sink { [weak self] region in
                let radius = region.span.latitudeDelta * 111 * 1000
                self?.requstPlaces(longitude: region.center.longitude, latitude: region.center.latitude, radius: radius)

            }
            .store(in: &bag)
    }

    func requstPlaces(longitude: Double, latitude: Double, radius: Double) {
        Task {
            do {
                let places = try await openMapClient.fetchPlaces(longitude: longitude, latitude: latitude, radius: radius, kinds: nil)
                print(places.count)
                await view.displayPlacse(places)
            } catch {
                print(error)
            }
        }
    }
}
