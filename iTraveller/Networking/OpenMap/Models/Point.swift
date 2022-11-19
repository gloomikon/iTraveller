public struct Point: Codable {
    public let longitude: Double
    public let latitude: Double

    enum CodingKeys: String, CodingKey {
        case longitude = "lon"
        case latitude = "lat"
    }
}
