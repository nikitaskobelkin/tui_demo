import Foundation
import Combine
@testable import TUI

final class MockNetworkService: NetworkServiceProtocol {
    private let session: FakeSession

    init(session: FakeSession) {
        self.session = session
    }

    func data<T: NetworkingRequest>(_ request: T) -> AnyPublisher<Data, NetworkError> {
        if let data = session.response?.data(using: .utf8) {
            return Result.Publisher(.success(data)).eraseToAnyPublisher()
        }
        if let error = session.error {
            return Fail(error: error).eraseToAnyPublisher()
        }
        return Fail(error: NetworkError.invalidError).eraseToAnyPublisher()
    }

    func json<T: NetworkingRequest>(_ request: T) -> AnyPublisher<T.ResponseType, NetworkError> {
        return data(request)
            .tryMap {
                let object = try JSONDecoder().decode(T.ResponseType.self, from: $0)
                return object
            }
            .mapError {
                guard let error = $0 as? NetworkError else {
                    return NetworkError.custom($0)
                }
                return error
            }
            .eraseToAnyPublisher()
    }
}
