// MARK: - Network Error

enum NetworkError: Error {
    case unauthorized
    case invalidJSON
    case invalidError
    case badRequest
    case unprocessableEntity
    case forbidden
    case noConnection
    case custom(Error)
}
