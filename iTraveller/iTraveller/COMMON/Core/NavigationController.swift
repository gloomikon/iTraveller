import UIKit

class NavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = false

        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .background.withAlphaComponent(0.85)
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.primary500,
            .font: UIFont.headingsH4SemiBold
        ]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundEffect = .some(.init(style: .light))

        navigationBar.tintColor = .primary500
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
}
