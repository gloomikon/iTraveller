import KUIKit
import UIKit

class FavoritesViewController: UITableViewController {

    private lazy var dataSource = makeDataSource()
    private let presenter: FavoritesPresenter

    init(presenter: FavoritesPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        tableView.register(type: FavoriteTableViewCell.self)

        presenter.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == Section.favorites.rawValue {
            presenter.didSelectFavorite(at: indexPath.row)
        }
    }
}

extension FavoritesViewController {
    func display(_ favorites: [PlaceInfo]) {
        applySnapshot(favorites)
    }
}

extension FavoritesViewController {
    enum Section: Int {
        case favorites
    }

    enum Field: Hashable {
        case favorite(PlaceInfo)
    }

    typealias DataSource = UITableViewDiffableDataSource<Section, Field>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Field>

    private func makeDataSource() -> DataSource {
        .init(tableView: tableView) { tableView, indexPath, field in
            switch field {
            case .favorite(let favorite):
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: FavoriteTableViewCell.reuseIdentifier,
                    for: indexPath
                ) as? FavoriteTableViewCell
                cell?.configure(with: favorite)
                return cell
            }
        }
    }

    private func applySnapshot(_ favorites: [PlaceInfo], animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([.favorites])
        snapshot.appendItems(favorites.map { .favorite($0) }, toSection: .favorites)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}
