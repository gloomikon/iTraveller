import Networking

struct PlaceInfo: Codable {
    let kinds: [PlaceKind]
    let point: Point
    let xid: String
    let name: String
    let wikipedia: String?
    let image: String
    let description: String

    init(_ placeInfo: Networking.PlaceInfo) {
        self.kinds = placeInfo.kinds.split(separator: ",").map(String.init).compactMap { .init(rawValue: $0) }
        self.point = .init(point: placeInfo.point)
        self.xid = placeInfo.xid
        self.name = placeInfo.name
        self.wikipedia = placeInfo.wikipedia
        self.image = placeInfo.preview.source
        self.description = placeInfo.info?.description ?? placeInfo.wikipediaExtracts?.text ?? ""
    }
}

extension PlaceInfo: Hashable {
    static func == (lhs: PlaceInfo, rhs: PlaceInfo) -> Bool {
        lhs.xid == rhs.xid
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(xid)
    }
}
