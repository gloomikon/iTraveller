import KUIKit
import UIKit

class RouteViewContoller: UITableViewController {

    private lazy var dataSource = makeDataSource()

    private let presenter: RoutePresenter
    private var viewState: ViewState?

    init(presenter: RoutePresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        tableView.register(type: RouteServiceTableViewCell.self)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier)

        presenter.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let viewState else { return nil }
        let label = UILabel()
        label.font = .headingsH3Bold
        label.text = viewState.sections[section].type.title
        return label
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let viewState else { return }
        let field = viewState.sections[indexPath.section].fields[indexPath.row]
        switch field {
        case .routeService(let service):
            presenter.selectedService(service)
        case .buildRoute:
            presenter.buildRouteTapped()
        }
    }
}

extension RouteViewContoller {
    func display(_ viewState: ViewState) {
        self.viewState = viewState
        applySnapshot(viewState)

    }
}

// MARK: - Diffable data source
extension RouteViewContoller {
    enum Section {
        case living
        case transportation
        case additional

        var title: String {
            switch self {
            case .living:
                return "Living"
            case .transportation:
                return "Transportation"
            case .additional:
                return "Additional"
            }
        }
    }

    enum Field: Hashable {
        case routeService(RouteService)
        case buildRoute
    }

    // swiftlint:disable nesting
    struct ViewState {
        struct Section {
            let type: RouteViewContoller.Section
            let fields: [Field]
        }

        let sections: [Section]
    }

    typealias DataSource = UITableViewDiffableDataSource<Section, Field>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Field>

    private func makeDataSource() -> DataSource {
        .init(tableView: tableView) { tableView, indexPath, field in
            switch field {
            case .routeService(let service):
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: RouteServiceTableViewCell.reuseIdentifier,
                    for: indexPath
                ) as? RouteServiceTableViewCell
                cell?.configure(with: service)
                return cell
            case .buildRoute:
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: UITableViewCell.reuseIdentifier,
                    for: indexPath
                )
                cell.backgroundColor = .clear
                cell.textLabel?.text = "build_route".localized
                return cell
            }
        }
    }

    private func applySnapshot(_ viewState: ViewState, animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections(viewState.sections.map(\.type))
        viewState.sections.forEach { section in
            snapshot.appendItems(section.fields, toSection: section.type)
        }
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}
