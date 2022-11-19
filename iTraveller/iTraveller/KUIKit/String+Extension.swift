import UIKit

public extension String {
    var localized: String {
        Bundle.main.localizedString(forKey: self, value: nil, table: nil)
    }

    func localized(arguments: CVarArg...) -> String {
        String(format: self.localized, arguments: arguments)
    }
}
