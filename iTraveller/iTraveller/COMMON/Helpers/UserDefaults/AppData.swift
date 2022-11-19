enum AppData {
    @Storage(key: "onboarding_passed", defaultValue: false)
    static var onboardingPassed: Bool

    @Storage(key: "favorites_places", defaultValue: [])
    static var favoritesPlaces: [PlaceInfo]
}
