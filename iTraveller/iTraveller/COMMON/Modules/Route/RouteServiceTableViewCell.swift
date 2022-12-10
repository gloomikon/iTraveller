import UIKit

class RouteServiceTableViewCell: UITableViewCell {

    @IBOutlet var iconImageView: UIImageView! {
        didSet {
            iconImageView.layer.cornerRadius = 8
        }
    }

    @IBOutlet var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 16
    }

    func configure(with service: RouteService) {
        titleLabel.text = service.title
        iconImageView.image = service.image
    }
}

extension RouteService {
    var title: String {
        rawValue.localized
    }

    var image: UIImage? {
        .init(named: rawValue)
    }
}
