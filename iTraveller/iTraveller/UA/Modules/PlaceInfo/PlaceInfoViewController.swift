import UIKit

class PlaceInfoViewController: BasePlaceInfoViewController {

    private let analyticsService: AnalyticsService

    init(
        analyticsService: AnalyticsService,
        presenter: PlaceInfoPresenter
    ) {
        self.analyticsService = analyticsService
        super.init(presenter: presenter)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func display(_ viewState: BasePlaceInfoViewController.ViewState) {
        analyticsService.send(.infoPageShown(xid: viewState.xid))
        super.display(viewState)
    }
}
