import MapKit

class ClusterAnnotationView: MKAnnotationView {

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        collisionMode = .circle
        centerOffset = CGPoint(x: 0, y: -10) // Offset center point to animate better with marker annotations
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// - Tag: CustomCluster
    override func prepareForDisplay() {
        super.prepareForDisplay()

        drawFractions()
    }

    private func drawFractions() {
        if let cluster = annotation as? MKClusterAnnotation {
            let totalPlaces = cluster.memberAnnotations.count

            let fractions = PlaceKind.allCases.map { (count(placeKind: $0), $0) }

            image = drawRatio(from: fractions, total: totalPlaces)
            displayPriority = .defaultHigh
        }
    }

    private func drawRatio(from fractions: [(fraction: Int, kind: PlaceKind)], total: Int) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 40, height: 40))
        return renderer.image { _ in
            var startAngle: CGFloat = 0

            fractions.forEach { fraction, kind in
                kind.markerTintColor.setFill()
                let piePath = UIBezierPath()
                let endAngle = startAngle + .pi * 2 * CGFloat(fraction) / CGFloat(total)
                piePath.addArc(
                    withCenter: CGPoint(x: 20, y: 20),
                    radius: 20,
                    startAngle: startAngle,
                    endAngle: endAngle,
                    clockwise: true
                )
                piePath.addLine(to: CGPoint(x: 20, y: 20))
                piePath.close()
                piePath.fill()

                startAngle = endAngle
            }

            // Fill inner circle with white color
            UIColor.white.setFill()
            UIBezierPath(ovalIn: CGRect(x: 8, y: 8, width: 24, height: 24)).fill()

            // Finally draw count text vertically and horizontally centered
            let attributes = [
                NSAttributedString.Key.foregroundColor: UIColor.black,
                NSAttributedString.Key.font: UIFont.captionMBold
            ]
            let text = "\(total)"
            let size = text.size(withAttributes: attributes)
            let rect = CGRect(x: 20 - size.width / 2, y: 20 - size.height / 2, width: size.width, height: size.height)
            text.draw(in: rect, withAttributes: attributes)
        }
    }

    private func count(placeKind kind: PlaceKind) -> Int {
        guard let cluster = annotation as? MKClusterAnnotation else {
            return 0
        }

        return cluster.memberAnnotations.filter { member -> Bool in
            guard let annotation = member as? PlaceAnnotation else {
                fatalError("Found unexpected annotation type")
            }
            return annotation.place.mainKind == kind
        }.count
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            drawFractions()
        }
    }
}
