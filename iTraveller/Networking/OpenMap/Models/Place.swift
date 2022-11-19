import KUIKit

public struct Place: Decodable {
    public let xid: String
    public let name: String
    public let kinds: String
    public let point: Point
}
