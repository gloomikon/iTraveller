class OpenMapClient: HTTPClient {

    func fetchPlaces(
        longitude: Double,
        latitude: Double,
        radius: Double,
        kinds: [String]?,
        limit: Int
    ) async throws -> [Place] {
        try await sendRequest(
            endpoint: PlacesEndpoint.radius(
                longitude: longitude,
                latitude: latitude,
                radius: radius,
                kinds: kinds,
                limit: limit
            ),
            responseModel: [Place].self
        )
    }

    func fetchPlace(with xid: String) async throws -> Place {
        try await sendRequest(
            endpoint: PlacesEndpoint.xid(xid),
            responseModel: Place.self
        )
    }
}
