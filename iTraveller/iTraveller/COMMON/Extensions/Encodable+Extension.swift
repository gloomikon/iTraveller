import Foundation

extension Encodable {
    var encoded: Data? {
        try? JSONEncoder().encode(self)
    }
}
