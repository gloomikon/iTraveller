import Foundation

public extension Encodable {
    var encoded: Data? {
        try? JSONEncoder().encode(self)
    }
}
