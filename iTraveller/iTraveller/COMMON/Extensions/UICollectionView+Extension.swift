import UIKit

extension UICollectionView {
    func register(type: UICollectionViewCell.Type) {
        self.register(type.nib, forCellWithReuseIdentifier: type.reuseIdentifier)
    }
}
