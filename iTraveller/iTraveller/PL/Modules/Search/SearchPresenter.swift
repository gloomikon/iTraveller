class SearchPresenter {
    private let coordinator: SearchCoordinator

    init(
        coordinator: SearchCoordinator
    ) {
        self.coordinator = coordinator
    }

    unowned private var view: SearchViewController!

    func inject(view: SearchViewController) {
        self.view = view
    }
}
