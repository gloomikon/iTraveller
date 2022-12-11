import Kingfisher
import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {

    @IBOutlet private var containerView: UIView! {
        didSet {
            containerView.backgroundColor = .background.withAlphaComponent(0.8)
        }
    }

    @IBOutlet private var placeTitleLabel: UILabel! {
        didSet {
            placeTitleLabel.font = .bodyMedium
            placeTitleLabel.textColor = .black600
        }
    }

    @IBOutlet private var placeImagaView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 16
    }

    func configure(with placeInfo: PlaceInfo) {
        placeTitleLabel.text = placeInfo.name
        if let url = URL(string: placeInfo.image) {
            placeImagaView.kf.setImage(with: url)
        }
    }
}
