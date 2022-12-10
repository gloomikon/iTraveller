public protocol Event {
    var name: String { get }
    var params: [String: Any]? { get }
}
