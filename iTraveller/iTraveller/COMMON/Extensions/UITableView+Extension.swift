import UIKit

extension UITableView {
    func register(type: UITableViewCell.Type) {
        self.register(type.nib, forCellReuseIdentifier: type.reuseIdentifier)
    }
}
