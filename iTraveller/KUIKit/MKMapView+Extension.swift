import MapKit

public extension MKMapView {
    func register(_ markerAnnotation: MKMarkerAnnotationView.Type) {
        self.register(
            markerAnnotation,
            forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier
        )
    }

    func register(_ clusterAnnotation: MKAnnotationView.Type) {
        self.register(
            clusterAnnotation,
            forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier
        )
    }
}
