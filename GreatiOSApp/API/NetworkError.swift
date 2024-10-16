enum NetworkError: Error {
    case encodingError(String)
    case decodingError(String)
    case response(String)
    case noToken
    case badURL
    case noCredentials
    case unavailable
}
