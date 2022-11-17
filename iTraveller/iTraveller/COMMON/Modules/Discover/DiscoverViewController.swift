import Combine
import MapKit
import UIKit

class DiscoverViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet private var mapView: MKMapView! {
        didSet {
            mapView.delegate = self
            mapView.register(PlaceAnnotationView.self)
            mapView.register(ClusterAnnotationView.self)
        }
    }

    private let presenter: DiscoverPresenter

    var currentRegionSubject: PassthroughSubject<MKCoordinateRegion, Never> = .init()

    init(presenter: DiscoverPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        currentRegionSubject.send(mapView.region)
    }
}

extension DiscoverViewController {
    func displayPlacse(_ places: [Place]) {
        mapView.removeAnnotations(mapView.annotations)

        let annonations: [PlaceAnnotation] = places.map {
            let annonation = PlaceAnnotation(place: $0)
            annonation.coordinate = .init(latitude: $0.point.latitude, longitude: $0.point.longitude)
            return annonation
        }

        mapView.addAnnotations(annonations)

        if let annotations = mapView.annotations as? [PlaceAnnotation] {
            mapView.removeAnnotations(mapView.annotations)
            mapView.addAnnotations(Array(Set(annotations)))
        }
    }
}

// MARK: - MKMapViewDelegate
extension DiscoverViewController: MKMapViewDelegate {
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        currentRegionSubject.send(mapView.region)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? PlaceAnnotation else { return nil }
        let view = PlaceAnnotationView(annonation: annotation)
        view.canShowCallout = true
        let label = UILabel().then { $0.text = annotation.place.name }
        view.detailCalloutAccessoryView = label
        view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)

        return view
    }

    func mapView(
        _ mapView: MKMapView,
        annotationView view: MKAnnotationView,
        calloutAccessoryControlTapped control: UIControl
    ) {
        guard let annotation = view.annotation as? PlaceAnnotation else { return }
        presenter.navigateToPlaceInfo(xid: annotation.place.xid)
    }
}
