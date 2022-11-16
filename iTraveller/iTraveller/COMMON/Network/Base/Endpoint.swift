import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var queryParameters: [String: String]? { get }
    var body: Data? { get }
}

extension Endpoint {
    var scheme: String {
        "https"
    }

    var host: String {
        "api.opentripmap.com"
    }

    var headers: [String: String]? {
        ["Accept": "application/json"]
    }

    private var baseQueryParameters: [String: String] {
        ["apikey": APIConstant.apikey]
    }

    var fullQueryParameters: [String: String] {
        if let queryParameters {
            return baseQueryParameters.merging(queryParameters) { _, new in new }
        } else {
            return baseQueryParameters
        }
    }

    var body: Data? {
        nil
    }
}
