import UIKit
import KUIKit

class FilterViewController: UITableViewController {

    typealias Cell = PlaceKindTableViewCell

    private lazy var dataSoure = makeDataSource()

    // MARK: - Injected properties

    private let presenter: FilterPresenter

    init(presenter: FilterPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        tableView.register(type: Cell.self)

        presenter.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - FilterViewProtocol
extension FilterViewController {
    func displayPlaceKinds(_ placeKinds: [PlaceKind]) {
        applySnapshot(kinds: placeKinds)
    }
}

// MARK: - DiffableDataSource
extension FilterViewController {

    enum Section {
        case main
    }

    typealias DataSource = UITableViewDiffableDataSource<Section, PlaceKind>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, PlaceKind>

    private func makeDataSource() -> DataSource {
        .init(tableView: tableView) { tableView, indexPath, placeKind in
            let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell
            cell?.configure(with: placeKind)
            return cell
        }
    }

    private func applySnapshot(kinds: [PlaceKind], animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(kinds)
        dataSoure.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}
