import UIKit

extension UIFont {

    static var bodyBold: UIFont {
        customFont("Lato-Bold", size: 16.0)
    }

    static var bodyLight: UIFont {
        customFont("Lato-Light", size: 16.0)
    }

    static var bodyMedium: UIFont {
        customFont("Lato-Medium", size: 16.0)
    }

    static var bodyRegular: UIFont {
        customFont("Lato-Regular", size: 16.0)
    }

    static var bodySemiBold: UIFont {
        customFont("Lato-SemiBold", size: 16.0)
    }

    static var captionLBold: UIFont {
        customFont("Lato-Bold", size: 14.0)
    }

    static var captionLLight: UIFont {
        customFont("Lato-Light", size: 14.0)
    }

    static var captionLMedium: UIFont {
        customFont("Lato-Medium", size: 14.0)
    }

    static var captionLRegular: UIFont {
        customFont("Lato-Regular", size: 14.0)
    }

    static var captionMBold: UIFont {
        customFont("Lato-Bold", size: 12.0)
    }

    static var captionMMedium: UIFont {
        customFont("Lato-Medium", size: 12.0)
    }

    static var captionMRegular: UIFont {
        customFont("Lato-Regular", size: 12.0)
    }

    static var captionSBold: UIFont {
        customFont("Lato-Bold", size: 10.0)
    }

    static var captionSMedium: UIFont {
        customFont("Lato-Medium", size: 10.0)
    }

    static var captionSRegular: UIFont {
        customFont("Lato-Regular", size: 10.0)
    }

    static var headingsH1: UIFont {
        customFont("Lato-Black", size: 32.0)
    }

    static var headingsH2Black: UIFont {
        customFont("Lato-Black", size: 28.0)
    }

    static var headingsH3Bold: UIFont {
        customFont("Lato-Bold", size: 24.0)
    }

    static var headingsH3SemiBold: UIFont {
        customFont("Lato-SemiBold", size: 24.0)
    }

    static var headingsH4Bold: UIFont {
        customFont("Lato-Bold", size: 20.0)
    }

    static var headingsH4SemiBold: UIFont {
        customFont("Lato-SemiBold", size: 20.0)
    }

    static var titleMedium: UIFont {
        customFont("Lato-Medium", size: 18.0)
    }

    static var titleRegular: UIFont {
        customFont("Lato-Regular", size: 18.0)
    }

    static var titleSemiBold: UIFont {
        customFont("Lato-SemiBold", size: 18.0)
    }

    private static func customFont(
        _ name: String,
        size: CGFloat,
        textStyle: UIFont.TextStyle? = nil,
        scaled: Bool = false
    ) -> UIFont {
        guard let font = UIFont(name: name, size: size) else {
            print("Warning: Font \(name) not found.")
            return UIFont.systemFont(ofSize: size, weight: .regular)
        }

        if scaled, let textStyle = textStyle {
            let metrics = UIFontMetrics(forTextStyle: textStyle)
            return metrics.scaledFont(for: font)
        } else {
            return font
        }
    }
}
