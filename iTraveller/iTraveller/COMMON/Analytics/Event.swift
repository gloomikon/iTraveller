// swiftlint:disable type_name

import Analytics

enum iTravallerEvent {
    case switchedTab(fromTab: Tab, toTab: Tab)
    case infoPageShown(xid: String)
}

extension iTravallerEvent: Analytics.Event {
    var name: String {
        switch self {
        case .switchedTab:
            return "switched_tab"
        case .infoPageShown:
            return "info_page_shown"
        }
    }

    var params: [String: Any]? {
        switch self {
        case .switchedTab(let fromTab, let toTab):
            return [
                "from_tab": fromTab.index,
                "to_tab": toTab.index
            ]
        case .infoPageShown(let xid):
            return [
                "xid": xid
            ]
        }
    }
}
