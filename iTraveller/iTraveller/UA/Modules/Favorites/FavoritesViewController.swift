import KUIKit
import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet private var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.register(type: FavoriteCollectionViewCell.self)
            collectionView.contentInset.top = 16
        }
    }

    @IBOutlet private var flowLayout: UICollectionViewFlowLayout! {
        didSet {
            flowLayout.minimumLineSpacing = 16
        }
    }

    private lazy var dataSource = makeDataSource()
    private let presenter: FavoritesPresenter

    init(presenter: FavoritesPresenter) {
        self.presenter = presenter
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = .zero
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background

        presenter.viewDidLoad()
    }
}

extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout _: UICollectionViewLayout,
        sizeForItemAt _: IndexPath
    ) -> CGSize {
        let width = (collectionView.bounds.width - 15) / 2
        let height = width / 164 * 212
        return .init(width: width, height: height)
    }
}

extension FavoritesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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

    typealias DataSource = UICollectionViewDiffableDataSource<Section, Field>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Field>

    private func makeDataSource() -> DataSource {
        .init(collectionView: collectionView) { collectionView, indexPath, field in
            switch field {
            case .favorite(let favorite):
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: FavoriteCollectionViewCell.reuseIdentifier,
                    for: indexPath
                ) as? FavoriteCollectionViewCell
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
