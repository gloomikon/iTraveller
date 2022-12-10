import UIKit

class BasePlaceInfoViewController: UIViewController {

    private enum Section {
        case main
    }

    private typealias Cell = PlaceKindCollectionViewCell
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, PlaceKind>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, PlaceKind>
    private lazy var dataSource: DataSource = makeDataSource()

    @IBOutlet private var contentView: UIView! {
        didSet {
            contentView.backgroundColor = .background
        }
    }

    @IBOutlet private var imageView: UIImageView! {
        didSet {
            imageView.contentMode = .scaleAspectFill
        }
    }

    @IBOutlet private var infoButton: UIButton! {
        didSet {
            infoButton.tintColor = .primary100
            infoButton.backgroundColor = .primary500.withAlphaComponent(0.8)
            infoButton.layer.cornerRadius = 10
            infoButton.isHidden = true
        }
    }

    @IBOutlet private var titleLabel: UILabel! {
        didSet {
            titleLabel.font = .headingsH1
            titleLabel.textColor = .black800
            titleLabel.numberOfLines = 0
        }
    }

    @IBOutlet var collectionView: UICollectionView! {
        didSet {
            collectionView.register(type: Cell.self)
            collectionView.clipsToBounds = false
        }
    }

    @IBOutlet private var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.font = .bodyRegular
            descriptionLabel.textColor = .black700
            descriptionLabel.numberOfLines = 0
        }
    }

    private let presenter: PlaceInfoPresenter

    init(presenter: PlaceInfoPresenter) {
        self.presenter = presenter
        super.init(nibName: "BasePlaceInfoViewController", bundle: .main)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(_ xid: String) {
        presenter.set(xid)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        setLoadingEnabled(true)

        presenter.viewDidLoad()
    }

    // MARK: - Public interface

    struct ViewState {
        let xid: String
        let image: UIImage
        let title: String
        let wikiURL: URL?
        let kinds: [PlaceKind]
        let description: String
    }

    func display(_ viewState: ViewState) {
        imageView.image = viewState.image
        if let url = viewState.wikiURL {
            infoButton.isHidden = false
            infoButton.addAction(
                .init(handler: { _ in
                    UIApplication.shared.open(url)
                }),
                for: .touchUpInside
            )
        }
        titleLabel.text = viewState.title

        applySnapshot(kinds: viewState.kinds, animatingDifferences: true)

        descriptionLabel.text = viewState.description
    }
}

// MARK: - DiffableDataSource
extension BasePlaceInfoViewController {
    private func makeDataSource() -> DataSource {
        .init(collectionView: collectionView) { collectionView, indexPath, kind in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Cell.reuseIdentifier,
                for: indexPath) as? Cell else {
                return UICollectionViewCell()
            }
            cell.configure(with: kind)
            return cell
        }
    }

    private func applySnapshot(kinds: [PlaceKind], animatingDifferences: Bool) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(kinds)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}
