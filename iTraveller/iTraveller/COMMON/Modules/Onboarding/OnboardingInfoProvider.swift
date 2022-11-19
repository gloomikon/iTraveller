import KUIKit

class OnboardingInfoProvider {
    func getInfo(for page: Int) -> OnboardingInfo {
        .init(
            title: "onboarding_title_\(page)".localized,
            subtitle: "onboarding_subtitle_\(page)".localized,
            image: .init(named: "onboarding_image_\(page)")
        )
    }
}
