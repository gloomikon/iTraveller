import Combine
import MapKit
import UIKit

class DiscoverViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet private var mapView: MKMapView! {
        didSet {
            mapView.delegate = self
        }
    }

    private let presenter: DiscoverPresenter

    var currentRegionSubject: PassthroughSubject<MKCoordinateSpan, Never> = .init()

    init(presenter: DiscoverPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension DiscoverViewController: MKMapViewDelegate {
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        currentRegionSubject.send(mapView.region.span)
    }
}
