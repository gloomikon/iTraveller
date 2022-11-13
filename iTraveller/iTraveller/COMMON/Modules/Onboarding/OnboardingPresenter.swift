class OnboardingPresenter {

    private let onboardingInfoProvider: OnboardingInfoProvider

    init(onboardingInfoProvider: OnboardingInfoProvider) {
        self.onboardingInfoProvider = onboardingInfoProvider
    }

    private var view: OnboardingViewController!
    private var coordinator: OnboardingCoordinator!

    func inject(
        view: OnboardingViewController,
        coordinator: OnboardingCoordinator!
    ) {
        self.view = view
        self.coordinator = coordinator
    }

    var page: Int!
}

extension OnboardingPresenter {
    func viewDidLoad() {
        let info = onboardingInfoProvider.getInfo(for: page)
        view.displayInfo(info)
    }

    func continueButtonTapped() {
        coordinator.goToNextScreen()
    }
}
