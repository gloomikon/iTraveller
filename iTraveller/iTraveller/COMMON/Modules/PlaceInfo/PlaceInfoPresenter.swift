import UIKit

class PlaceInfoPresenter {

    private let coordinator: PlaceInfoCoordinator
    private let openMapClient: OpenMapClient

    init(
        coordinator: PlaceInfoCoordinator,
        openMapClient: OpenMapClient
    ) {
        self.coordinator = coordinator
        self.openMapClient = openMapClient
    }

    private unowned var view: PlaceInfoViewController!

    func inject(view: PlaceInfoViewController) {
        self.view = view
    }

    private var xid: String!
}

extension PlaceInfoPresenter {
    func set(_ xid: String) {
        self.xid = xid
    }

    func viewDidLoad() {
        Task {
            do {
                let placeInfo = try await self.openMapClient.fetchPlaceInfo(with: xid)

                print(placeInfo.kinds)
                print(placeInfo.description)

                let imageData = try? await self.openMapClient.fetchImageData(from: placeInfo.image)

                let image = imageData.map {
                    UIImage(data: $0) ?? UIImage(named: "place_placeholder")! }
                ?? UIImage(named: "place_placeholder")!
                var url: URL?
                if let wikipedia = placeInfo.wikipedia {
                    url = URL(string: wikipedia)
                }

                let viewState = PlaceInfoViewController.ViewState(
                    image: image,
                    title: placeInfo.name,
                    wikiURL: url,
                    kinds: placeInfo.kinds,
                    description: placeInfo.description
                )

                print(viewState.kinds)

                await self.view.display(viewState)
            } catch {
                print(error)
            }
        }
    }
}