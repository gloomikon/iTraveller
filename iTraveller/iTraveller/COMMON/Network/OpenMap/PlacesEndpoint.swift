import Foundation

enum PlacesEndpoint {
    case radius(longitude: Double, latitude: Double, radius: Double, kinds: [String]?)
    case xid(String)

    var basePath: String { "places" }

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
    var path: String {
        [basePath, concretePath].joined(separator: "/")
    }

    var method: HTTPMethod {
        .get
    }

    var queryParameters: [String : String]? {
        switch self {
        case .radius(let longitude, let latitude, let radius, let kinds):
            var params = [
                "lon": longitude.description,
                "lat": latitude.description,
                "radius": radius.description
            ]
            if let kinds {
                params["kinds"] = kinds.joined(separator: ",")
            }
            return params
        case .xid:
            return nil
        }
    }
}
