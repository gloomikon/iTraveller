import Foundation

public enum PlacesEndpoint {
    case radius(longitude: Double, latitude: Double, radius: Double, kinds: [String]?, limit: Int)
    case xid(String)

    var basePath: String { "/0.1/en/places" }

    var concretePath: String {
        switch self {
        case .radius:
            return "radius"
        case .xid(let xid):
            return "xid/\(xid)"
        }
    }
}

extension PlacesEndpoint: Endpoint {
    public var path: String {
        [basePath, concretePath].joined(separator: "/")
    }

    public var method: HTTPMethod {
        .get
    }

    public var queryParameters: [String: String]? {
        switch self {
        case .radius(let longitude, let latitude, let radius, let kinds, let limit):
            return [
                "lon": longitude.description,
                "lat": latitude.description,
                "radius": radius.description,
                "format": "json",
                "kinds": kinds.map { $0.joined(separator: ",") } ?? "interesting_places,tourist_facilities",
                "rate": "3",
                "limit": limit.description
            ]
        case .xid:
            return nil
        }
    }
}
