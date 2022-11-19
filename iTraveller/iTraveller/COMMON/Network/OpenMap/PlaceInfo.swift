// swiftlint:disable nesting

struct PlaceInfo: Decodable {
    let kinds: [PlaceKind]
    let point: Point
    let xid: String
    let name: String
    let wikipedia: String?
    let image: String
    let description: String

    enum CodingKeys: String, CodingKey {
        case kinds
        case point
        case xid
        case name
        case wikipedia
        case image
        case info
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let kinds = try container.decode(String.self, forKey: CodingKeys.kinds)
        self.kinds = kinds.split(separator: ",").map(String.init).compactMap { PlaceKind(rawValue: $0)}
        point = try container.decode(Point.self, forKey: CodingKeys.point)
        xid = try container.decode(String.self, forKey: CodingKeys.xid)
        name = try container.decode(String.self, forKey: CodingKeys.name)
        wikipedia = try container.decode(String?.self, forKey: CodingKeys.wikipedia)
        image = try container.decode(String.self, forKey: CodingKeys.image)
        let info = try container.decode(Info.self, forKey: CodingKeys.info)
        self.description = info.description
    }

}

extension PlaceInfo {
    struct Info: Decodable {
        let description: String

        enum CodingKeys: String, CodingKey {
            case description = "descr"
        }
    }
}
