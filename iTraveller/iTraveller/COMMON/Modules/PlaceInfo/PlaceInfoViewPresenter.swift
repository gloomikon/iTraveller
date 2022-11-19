class PlaceInfoPresenter {

    private let coordinator: PlaceInfoCoordinator

    init(coordinator: PlaceInfoCoordinator) {
        self.coordinator = coordinator
    }

    private unowned var view: PlaceInfoViewController!

    func inject(view: PlaceInfoViewController) {
        self.view = view
    }
}
