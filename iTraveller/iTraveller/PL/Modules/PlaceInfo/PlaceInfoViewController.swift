import StoreKit

class PlaceInfoViewController: BasePlaceInfoViewController {
    override func display(_ viewState: BasePlaceInfoViewController.ViewState) {
        super.display(viewState)
        if let scene = UIApplication.shared.connectedScenes.first(
            where: { $0.activationState == .foregroundActive }
        ) as? UIWindowScene {
            DispatchQueue.main.async {
                SKStoreReviewController.requestReview(in: scene)
            }
        }
    }
}
