import MapKit

class PlaceAnnotation: NSObject, MKAnnotation {

    let place: Place

    init(place: Place) {
        self.place = place
    }

    private var latitude: CLLocationDegrees = 0
    private var longitude: CLLocationDegrees = 0

    // This property must be key-value observable, which the `@objc dynamic` attributes provide.
    @objc dynamic var coordinate: CLLocationCoordinate2D = .init(latitude: 0, longitude: 0)
}
