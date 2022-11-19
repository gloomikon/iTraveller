import KUIKit
import UIKit

enum ToastType {
    case success
    case warning
    case error
}

class ToastView: NibInitiableView {

    @IBOutlet private var imageView: UIImageView!

    @IBOutlet private var textLabel: UILabel!

    var font: UIFont {
        get {
            textLabel.font
        }
        set {
            textLabel.font = newValue
        }
    }

    var textColor: UIColor {
        get {
            textLabel.textColor
        }
        set {
            textLabel.textColor = newValue
        }
    }

    override func setup() {
        super.setup()
        layer.cornerRadius = 12
    }

    func configure(with type: ToastType, text: String) {
        let imageName: String
        let tintColor: UIColor

        switch type {
        case .success:
            imageName = "checkmark.circle.fill"
            tintColor = .systemGreen
        case .warning:
            imageName = "exclamationmark.triangle.fill"
            tintColor = .systemYellow
        case .error:
            imageName = "xmark.circle.fill"
            tintColor = .systemRed
        }

        imageView.image = .init(systemName: imageName)
        imageView.tintColor = tintColor
        textLabel.text = text
    }
}
