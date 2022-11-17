import MapKit

extension MKMarkerAnnotationView {
    static var reuseIdentifier: String {
        String(describing: Self.self)
    }
}
