import KUIKit

enum RouteService: String, Hashable {
    enum `Type` {
        case living
        case transportation
    }

    case airbnb
    case booking
    case wizzair
    case flixbus
    case busfor

    var type: Type {
        switch self {
        case .airbnb,
             .booking:
            return .living
        case .wizzair,
             .flixbus,
             .busfor:
            return .transportation
        }
    }
}
