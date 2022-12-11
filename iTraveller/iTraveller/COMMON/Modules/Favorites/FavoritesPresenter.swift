import Combine

class FavoritesPresenter {
    private let coordinator: FavoritesCoordinator
    private let favoritesProvider: FavoritesProvider

    init(
        coordinator: FavoritesCoordinator,
        favoritesProvider: FavoritesProvider
    ) {
        self.coordinator = coordinator
        self.favoritesProvider = favoritesProvider
    }

    private var view: FavoritesViewController!

    func inject(
        view: FavoritesViewController
    ) {
        self.view = view
    }

    private var bag: Set<AnyCancellable> = .init()
    private var favorites: [PlaceInfo] = []
}

extension FavoritesPresenter {
    func viewDidLoad() {
        favoritesProvider.favorites
            .sink { [unowned self] favorites in
                self.favorites = favorites
                self.view.display(favorites)
            }
            .store(in: &bag)
    }

    func didSelectFavorite(at index: Int) {
        coordinator.openPlaceInfo(favorites[index])
    }
}
