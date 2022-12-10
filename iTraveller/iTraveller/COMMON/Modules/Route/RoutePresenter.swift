import Combine
import UIKit

class RoutePresenter {
    private let coordinator: RouteCoordinator
    private let routeSerivesProvider: RouteServicesProvider
    private let favoritesProvider: FavoritesProvider

    init(
        coordinator: RouteCoordinator,
        routeSerivesProvider: RouteServicesProvider,
        favoritesProvider: FavoritesProvider
    ) {
        self.coordinator = coordinator
        self.routeSerivesProvider = routeSerivesProvider
        self.favoritesProvider = favoritesProvider
    }

    private unowned var view: RouteViewContoller!

    func inject(view: RouteViewContoller) {
        self.view = view
    }

    private var bag: Set<AnyCancellable> = .init()
    private var services: [RouteService] = []
}

extension RoutePresenter {
    func viewDidLoad() {
        services = routeSerivesProvider.getServices()
        let livingServices = services.filter { $0.type == .living }
        let transportationServices = services.filter { $0.type == .transportation }

        var sections: [RouteViewContoller.ViewState.Section] = []
        if !livingServices.isEmpty {
            sections.append(.init(type: .living, fields: livingServices.map { .routeService($0) }))
        }
        if !transportationServices.isEmpty {
            sections.append(.init(type: .transportation, fields: transportationServices.map { .routeService($0) }))
        }

        favoritesProvider.favorites
            .receive(on: DispatchQueue.main)
            .map { $0.count > 1 }
            .sink { [unowned self] displayBuildRoute in
                if displayBuildRoute {
                    self.view.display(.init(
                        sections: sections + [.init(type: .additional, fields: [.buildRoute])]
                    ))
                } else {
                    self.view.display(.init(sections: sections))
                }
            }
        .store(in: &bag)
    }

    func selectedService(_ service: RouteService) {
        guard let serviceURL = service.url else { return }
        UIApplication.shared.open(serviceURL)
    }

    func buildRouteTapped() { }
}

extension RouteService {
    private var urlString: String {
        switch self {
        case .airbnb:
            return "https://www.airbnb.com/"
        case .booking:
            return "https://www.booking.com/"
        case .wizzair:
            return "https://wizzair.com/#/"
        case .flixbus:
            return "https://global.flixbus.com/"
        case .busfor:
            return "https://busfor.ua/"
        }
    }

    var url: URL? {
        .init(string: urlString)
    }
}
