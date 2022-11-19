import MapKit

class PlaceAnnotationView: MKMarkerAnnotationView {

    private let kind: PlaceKind

    init(annonation: PlaceAnnotation) {
        self.kind = annonation.place.mainKind
        super.init(annotation: annonation, reuseIdentifier: Self.reuseIdentifier)
        clusteringIdentifier = Self.reuseIdentifier
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// - Tag: DisplayConfiguration
    override func prepareForDisplay() {
        super.prepareForDisplay()
        displayPriority = .defaultHigh
        markerTintColor = kind.markerTintColor
        glyphImage = UIImage(named: kind.imageName)
        glyphTintColor = kind.imageColor
    }
}

extension PlaceKind {
    var markerTintColor: UIColor {
        switch self {
        case .architecture:
            return .secondary100
        case .cultural:
            return .primary100
        case .historic:
            return .error100
        case .natural:
            return .success100
        case .religion:
            return .warning300
        case .sport:
            return .secondary700
        case .touristFacilities:
            return .primary800
        case .unknown:
            return .error800
        }
    }

    var imageColor: UIColor {
        switch self {
        case .architecture:
            return .secondary800
        case .cultural:
            return .primary800
        case .historic:
            return .error800
        case .natural:
            return .success800
        case .religion:
            return .warning700
        case .sport:
            return .secondary100
        case .touristFacilities:
            return .primary100
        case .unknown:
            return .error200
        }
    }
}
