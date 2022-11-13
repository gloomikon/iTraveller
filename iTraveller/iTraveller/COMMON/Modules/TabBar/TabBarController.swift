import UIKit

class TabBarController: UITabBarController {
    private var prevTab: Tab?

    override var selectedIndex: Int {
        get { super.selectedIndex }
        set {
            super.selectedIndex = newValue
            prevTab = .init(rawValue: selectedIndex)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)

        tabBar.tintColor = .primary500
        tabBar.unselectedItemTintColor = .black800
        tabBar.backgroundColor = .background
        tabBar.layer.do {
            $0.shadowOffset = .init(width: 0, height: -4)
            $0.shadowRadius = 24
            $0.shadowOpacity = 1
            $0.shadowColor = UIColor.primary900.withAlphaComponent(0.05).cgColor
        }
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            tabBar.layer.do {
                $0.shadowColor = UIColor.primary900.withAlphaComponent(0.05).cgColor
            }
        }
    }
}
