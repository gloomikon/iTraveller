import KUIKit
import UIKit

class PlaceInfoPresenter {

    private let coordinator: PlaceInfoCoordinator
    private let openMapClient: OpenMapClient
    private let favoritesProvider: FavoritesProvider

    init(
        coordinator: PlaceInfoCoordinator,
        openMapClient: OpenMapClient,
        favoritesProvider: FavoritesProvider
    ) {
        self.coordinator = coordinator
        self.openMapClient = openMapClient
        self.favoritesProvider = favoritesProvider
    }

    private unowned var view: PlaceInfoViewController!

    func inject(view: PlaceInfoViewController) {
        self.view = view
    }

    private var xid: String?
    private var placeInfo: PlaceInfo?
}

extension PlaceInfoPresenter {
    func set(_ xid: String) {
        self.xid = xid
    }

    func set(_ placeInfo: PlaceInfo) {
        self.placeInfo = placeInfo
    }

    func viewDidLoad() {
        Task {
            if let xid {
                do {
                    let placeInfo = try await self.openMapClient.fetchPlaceInfo(with: xid)
                    self.placeInfo = placeInfo
                    await self.process(placeInfo)
                } catch {
                    await view.showToast(type: .error, text: "error_something_went_wrong".localized)
                }
            } else if let placeInfo {
                await self.process(placeInfo)
            }
        }
    }

    private func process(_ placeInfo: PlaceInfo) async {
        let imageData = try? await self.openMapClient.fetchImageData(from: placeInfo.image)

        let image = imageData.map {
            UIImage(data: $0) ?? UIImage(named: "place_placeholder")! }
        ?? UIImage(named: "place_placeholder")!
        var url: URL?
        if let wikipedia = placeInfo.wikipedia {
            url = URL(string: wikipedia)
        }

        let viewState = PlaceInfoViewController.ViewState(
            xid: placeInfo.xid,
            image: image,
            title: placeInfo.name,
            wikiURL: url,
            kinds: placeInfo.kinds,
            description: placeInfo.description,
            isFavorite: favoritesProvider.isFavorite(placeInfo)
        )

        await view.display(viewState)
        await view.setLoadingEnabled(false)
    }

    func toggleFavorite() {
        guard let placeInfo else { return }

        if favoritesProvider.isFavorite(placeInfo) {
            favoritesProvider.remove(placeInfo)
        } else {
            favoritesProvider.add(placeInfo)
        }

        Task {
            await self.process(placeInfo)
        }
    }
}
