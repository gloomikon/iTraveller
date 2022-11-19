public struct PlaceInfo: Decodable {
    public let kinds: String
    public let point: Point
    public let xid: String
    public let name: String
    public let wikipedia: String?
    public let preview: Preview
    public let info: Info?
    public let wikipediaExtracts: WikipediaExtracts?

    enum CodingKeys: String, CodingKey {
        case kinds
        case point
        case xid
        case name
        case wikipedia
        case preview
        case info
        case wikipediaExtracts = "wikipedia_extracts"
    }
}

extension PlaceInfo {
    public struct Info: Decodable {
        public let description: String

        enum CodingKeys: String, CodingKey {
            case description = "descr"
        }
    }

    public struct WikipediaExtracts: Decodable {
        public let text: String?
    }

    public struct Preview: Decodable {
        public let source: String
    }
}
