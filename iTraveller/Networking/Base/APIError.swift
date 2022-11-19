enum APIError: Error {
    case failedToDecode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
}
