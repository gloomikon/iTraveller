import Foundation

public protocol HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async throws -> T
    func sendRequest<T: Decodable>(from urlString: String, responseModel: T.Type) async throws -> T
    func sendRequest<T: Decodable>(from urlRequest: URLRequest, responseModel: T.Type) async throws -> T

    func sendRequest(endpoint: Endpoint) async throws -> Data
    func sendRequest(from urlString: String) async throws -> Data
    func sendRequest(from urlRequest: URLRequest) async throws -> Data
}

public extension HTTPClient {
    func sendRequest(endpoint: Endpoint) async throws -> Data {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.fullQueryParameters.map { key, value in
            URLQueryItem(name: key, value: value)
        }

        urlComponents.percentEncodedQuery = urlComponents.percentEncodedQuery?.replacingOccurrences(
            of: ",",
            with: "%2C"
        )

        guard let url = urlComponents.url else {
            throw APIError.invalidURL
        }

//        print("🌐 URL: \(url.absoluteString)")

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers
        request.httpBody = endpoint.body

       return try await sendRequest(from: request)
    }

    func sendRequest(from urlString: String) async throws -> Data {
        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue

        return try await sendRequest(from: request)
    }

    func sendRequest(from urlRequest: URLRequest) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(for: urlRequest, delegate: nil)
        guard let response = response as? HTTPURLResponse else {
            throw APIError.noResponse
        }
        switch response.statusCode {
        case 200...299:
            return data
        case 401:
            throw APIError.unauthorized
        default:
            throw APIError.unexpectedStatusCode
        }
    }

    func sendRequest<T: Decodable>(
        endpoint: Endpoint,
        responseModel: T.Type
    ) async throws -> T {
        let data = try await sendRequest(endpoint: endpoint)
        return try decode(data: data, for: responseModel)
    }

    func sendRequest<T: Decodable>(from urlString: String, responseModel: T.Type) async throws -> T {
        let data = try await sendRequest(from: urlString)
        return try decode(data: data, for: responseModel)
    }

    func sendRequest<T: Decodable>(from urlRequest: URLRequest, responseModel: T.Type) async throws -> T {
        let data = try await sendRequest(from: urlRequest)
        return try decode(data: data, for: responseModel)
    }

    private func decode<T: Decodable>(data: Data, for responseModel: T.Type) throws -> T {
        print(String(decoding: data, as: UTF8.self))
        return try JSONDecoder().decode(responseModel, from: data)
    }
}
