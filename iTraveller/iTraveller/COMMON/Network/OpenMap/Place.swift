// swiftlint:disable nesting

enum PlaceKind: String, Decodable, CaseIterable {
    case architecture
    case cultural
    case historic
    case natural
    case religion
    case sport
    case touristFacilities = "tourist_facilities"

    case unknown = "pin_placeholder"

    var imageName: String {
        rawValue
    }
}

struct Place: Decodable {
    let xid: String
    let name: String
    let kinds: [PlaceKind]
    let point: Point

    var mainKind: PlaceKind {
        kinds.first ?? .unknown
    }

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
        self.kinds = kinds.split(separator: ",").map(String.init).compactMap { PlaceKind(rawValue: $0)}
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
