import Combine

class FavoritesProvider {
    let favorites: CurrentValueSubject<[PlaceInfo], Never> = .init(AppData.favoritesPlaces)

    func add(_ place: PlaceInfo) {
        AppData.favoritesPlaces += [place]
        update()
    }

    func update(_ place: PlaceInfo) {
        guard let placeIndex = AppData.favoritesPlaces.firstIndex(where: { place.xid == $0.xid }) else {
            return
        }

        AppData.favoritesPlaces[placeIndex] = place
        update()
    }

    func remove(_ place: PlaceInfo) {
        guard let placeIndex = AppData.favoritesPlaces.firstIndex(where: { place.xid == $0.xid }) else {
            return
        }

        AppData.favoritesPlaces.remove(at: placeIndex)
        update()
    }

    func isFavorite(_ place: PlaceInfo) -> Bool {
        AppData.favoritesPlaces.contains(where: { $0.xid == place.xid })
    }

    private func update() {
        favorites.send(AppData.favoritesPlaces)
    }
}
