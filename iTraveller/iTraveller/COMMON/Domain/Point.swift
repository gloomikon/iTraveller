import Networking

struct Point: Codable {
    let longitude: Double
    let latitude: Double

    init(point: Networking.Point) {
        self.latitude = point.latitude
        self.longitude = point.longitude
    }
}
