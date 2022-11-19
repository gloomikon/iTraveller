import UIKit

class PlaceKindCollectionViewCell: UICollectionViewCell {
    @IBOutlet private var kindLabel: UILabel! {
        didSet {
            kindLabel.font = .bodyLight
        }
    }

    @IBOutlet private var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 20
        }
    }

    func configure(with kind: PlaceKind) {
        containerView.backgroundColor = kind.imageColor
        kindLabel.text = kind.displayTitle
        kindLabel.textColor = kind.markerTintColor
    }
}
