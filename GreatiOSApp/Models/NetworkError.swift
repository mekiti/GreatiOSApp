enum NetworkError: Error {
    case encodingError(String)
    case decodingError(String)
    case response(String)
}
