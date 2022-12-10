class FilterPresenter {
    unowned private var view: FilterViewController!

    func inject(view: FilterViewController) {
        self.view = view
    }
}

// MARK: - FilterPresenterProtocol
extension FilterPresenter {
    func viewDidLoad() {
        let kinds = PlaceKind.allCases.filter { $0 != .unknown }
        view.displayPlaceKinds(kinds)
    }
}
