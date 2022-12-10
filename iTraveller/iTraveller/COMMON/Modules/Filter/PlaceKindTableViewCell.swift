import UIKit

class PlaceKindTableViewCell: UITableViewCell {

    @IBOutlet private var checkbox: UIButton! {
        didSet {
            checkbox.setImage(.init(systemName: "checkmark.circle"), for: .normal)
        }
    }

    @IBOutlet private var titleLabel: UILabel! {
        didSet {
            titleLabel.font = .bodyMedium
        }
    }

    private var placeKindIsSelected = true

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(with placeKind: PlaceKind) {
        titleLabel.text = placeKind.displayTitle
        titleLabel.textColor = placeKind.markerTintColor
        checkbox.tintColor = placeKind.markerTintColor
        backgroundColor = placeKind.imageColor
    }

    @IBAction private func checkboxTapped(_ sender: Any) {
        placeKindIsSelected.toggle()

        checkbox.setImage(.init(systemName: placeKindIsSelected ? "checkmark.circle" : "circle"), for: .normal)
    }
}
