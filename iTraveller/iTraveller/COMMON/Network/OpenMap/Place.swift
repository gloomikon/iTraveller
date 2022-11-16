// swiftlint:disable nesting

enum Kind: String {
    case architecture
    case cultural
    case historic
    case natural
    case religion
    case sport
    case touristFacilities = "tourist_facilities"
}

struct Place: Decodable {
    let xid: String
    let name: String
    let kinds: [Kind]
    let point: Point

    enum CodingKeys: String, CodingKey {
        case xid
        case name
        case kinds
        case point
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        xid = try container.decode(String.self, forKey: CodingKeys.xid)
        name = try container.decode(String.self, forKey: CodingKeys.name)
        let kinds = try container.decode(String.self, forKey: CodingKeys.kinds)
        self.kinds = kinds.split(separator: ",").map(String.init).compactMap { Kind(rawValue: $0)}
        point = try container.decode(Point.self, forKey: CodingKeys.point)
    }
}

extension Place {
    struct Point: Decodable {
        let longitude: Double
        let latitude: Double

        enum CodingKeys: String, CodingKey {
            case longitude = "lon"
            case latitude = "lat"
        }
    }
}
