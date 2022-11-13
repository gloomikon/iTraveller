class OnboardingPresenter {

    private var view: OnboardingViewController!
    private var coordinator: OnboardingCoordinator!
    private let onboardingInfoProvider: OnboardingInfoProvider

    init(onboardingInfoProvider: OnboardingInfoProvider) {
        self.onboardingInfoProvider = onboardingInfoProvider
    }
    
    var page: Int!

    func inject(
        view: OnboardingViewController,
        coordinator: OnboardingCoordinator!
    ) {
        self.view = view
        self.coordinator = coordinator
    }
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
