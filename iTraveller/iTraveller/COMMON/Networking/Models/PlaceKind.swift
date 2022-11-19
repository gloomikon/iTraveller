import Networking

enum PlaceKind: String, Codable, CaseIterable {
    case architecture
    case cultural
    case historic
    case natural
    case religion
    case sport
    case touristFacilities = "tourist_facilities"

    case unknown = "pin_placeholder"

    var imageName: String {
        rawValue
    }

    private var title: String {
        rawValue.localized
    }

    var displayTitle: String {
        "#\(title)"
    }
}
