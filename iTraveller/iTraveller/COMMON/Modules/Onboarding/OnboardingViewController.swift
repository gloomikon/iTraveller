import UIKit

class OnboardingViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private var titleLabel: UILabel! {
        didSet {
            titleLabel.font = .headingsH1
            titleLabel.textColor = .black950
        }
    }

    @IBOutlet private var subtitleLabel: UILabel! {
        didSet {
            subtitleLabel.font = .headingsH3Bold
            subtitleLabel.textColor = .black900
        }
    }

    @IBOutlet private var imageView: UIImageView! {
        didSet {
            imageView.layer.cornerRadius = 16
        }
    }

    @IBOutlet private var continueButton: UIButton! {
        didSet {
            continueButton.setTitle("onboarding_button_title".localized(), for: .normal)
            continueButton.titleLabel?.font = .headingsH3SemiBold
            continueButton.backgroundColor = .primary500
            continueButton.titleLabel?.textColor = .constantWhite
            continueButton.layer.cornerRadius = 16
        }
    }

    init(presenter: OnboardingPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    func setPage(_ page: Int) {
        presenter.page = page
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let presenter: OnboardingPresenter

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        presenter.viewDidLoad()
    }

    @IBAction func continueButtonTapped(_ sender: Any) {
        presenter.continueButtonTapped()
    }
}

extension OnboardingViewController {
    func displayInfo(_ info: OnboardingInfo) {
        titleLabel.text = info.title
        subtitleLabel.text = info.subtitle
        imageView.image = info.image
    }
}
