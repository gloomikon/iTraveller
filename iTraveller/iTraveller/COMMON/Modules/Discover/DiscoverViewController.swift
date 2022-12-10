import Combine
import KFoundation
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

    @IBOutlet private var filtersButton: UIButton! {
        didSet {
            filtersButton.backgroundColor  = .background.withAlphaComponent(0.7)
            filtersButton.layer.cornerRadius = 6
        }
    }

    @IBOutlet private var locationButton: UIButton! {
        didSet {
            locationButton.backgroundColor  = .background.withAlphaComponent(0.7)
            locationButton.layer.cornerRadius = 6
            locationButton.isHidden = true
        }
    }

    var currentRegionSubject: PassthroughSubject<MKCoordinateRegion, Never> = .init()
    private let locationManager = CLLocationManager()
    private let regionRadiusMeters: Double = 5000

    // MARK: - Injected properties

    private let presenter: DiscoverPresenter

    init(presenter: DiscoverPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.do {
            $0.requestWhenInUseAuthorization()
            $0.desiredAccuracy = kCLLocationAccuracyBest
            $0.distanceFilter = kCLDistanceFilterNone
            $0.startUpdatingLocation()
        }

        centerMap()
        currentRegionSubject.send(mapView.region)

        if locationManager.authorizationStatus.isOne(of: .authorizedWhenInUse, .authorizedAlways) {
            locationButton.isHidden = false
            mapView.showsUserLocation = true
        }
    }

    private func centerMap() {
        let userCoordinate = locationManager.location?.coordinate ?? baseUserCoordinate
        let region = MKCoordinateRegion(
            center: userCoordinate,
            latitudinalMeters: regionRadiusMeters,
            longitudinalMeters: regionRadiusMeters
        )
        mapView.setRegion(region, animated: true)
    }

    @IBAction private func filterButtonTapped(_ sender: Any) {
        presenter.openFilters()
    }

    @IBAction private func locationButtonTap(_ sender: Any) {
        centerMap()
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
