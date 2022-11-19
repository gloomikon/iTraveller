import Foundation
import Networking

class OpenMapClient: HTTPClient {

    func fetchPlaces(
        longitude: Double,
        latitude: Double,
        radius: Double,
        kinds: [String]?,
        limit: Int
    ) async throws -> [Place] {
       let places = try await sendRequest(
            endpoint: PlacesEndpoint.radius(
                longitude: longitude,
                latitude: latitude,
                radius: radius,
                kinds: kinds,
                limit: limit
            ),
            responseModel: [Networking.Place].self
        )
        return places.map { .init($0) }
    }

    func fetchPlaceInfo(with xid: String) async throws -> PlaceInfo {
        let placeInfo = try await sendRequest(
            endpoint: PlacesEndpoint.xid(xid),
            responseModel: Networking.PlaceInfo.self
        )
        return .init(placeInfo)
    }

    func fetchImageData(from urlString: String) async throws -> Data {
        try await sendRequest(from: urlString)
    }
}
