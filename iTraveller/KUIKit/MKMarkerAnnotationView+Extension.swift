import MapKit

public extension MKMarkerAnnotationView {
    static var reuseIdentifier: String {
        String(describing: Self.self)
    }
}
