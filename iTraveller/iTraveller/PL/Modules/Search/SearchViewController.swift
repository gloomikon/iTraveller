import UIKit

class SearchViewController: UIViewController {

    @IBOutlet var searchBar: UISearchBar! {
        didSet {
            searchBar.barTintColor = .background
        }
    }

    private let presenter: SearchPresenter

    init(presenter: SearchPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
    }
}
