import Kingfisher
import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet private var placeTitleLabel: UILabel! {
        didSet {
            placeTitleLabel.font = .headingsH4Bold
            placeTitleLabel.textColor = .black600
        }
    }

    @IBOutlet private var placeImageView: UIImageView! {
        didSet {
            placeImageView.layer.cornerRadius = 16
        }
    }

    func configure(with placeInfo: PlaceInfo) {
        placeTitleLabel.text = placeInfo.name
        if let url = URL(string: placeInfo.image) {
            placeImageView.kf.setImage(with: url)
        }
    }
}
