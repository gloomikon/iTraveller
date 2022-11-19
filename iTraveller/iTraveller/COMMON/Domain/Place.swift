import Networking

struct Place {
    let xid: String
    let name: String
    let kinds: [PlaceKind]
    let point: Point

    init(_ place: Networking.Place) {
        self.xid = place.xid
        self.name = place.name
        self.kinds = place.kinds.split(separator: ",").map(String.init).compactMap { .init(rawValue: $0) }
        self.point = .init(point: place.point)
    }

    var mainKind: PlaceKind {
        kinds.first ?? .unknown
    }
}
