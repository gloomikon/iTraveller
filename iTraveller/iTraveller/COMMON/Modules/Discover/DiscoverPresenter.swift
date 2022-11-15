import Combine
import MapKit

class DiscoverPresenter {

    unowned private var view: DiscoverViewController!

    func inject(view: DiscoverViewController) {
        self.view = view

        bind()
    }

    private var bag: Set<AnyCancellable> = .init()

    func bind() {
        view.currentRegionSubject
            .throttle(for: 1, scheduler: RunLoop.main, latest: true)
            .sink { span in
                // Unlike longitudinal distances, which vary based on the latitude,
                // one degree of latitude is always approximately 111 kilometers (69 miles).
                let distance = span.latitudeDelta * 111 * 1000
                print("Distance = \(distance) meters")
            }
            .store(in: &bag)
    }
}
