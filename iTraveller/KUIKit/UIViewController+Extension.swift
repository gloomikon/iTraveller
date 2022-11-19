import UIKit

public extension UIViewController {
    var topParent: UIViewController? {
        guard var topParent = parent else {
            return nil
        }

        while topParent.parent != nil {
            topParent = topParent.parent!
        }

        return topParent
    }
}
