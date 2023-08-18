import Foundation
import Combine

protocol NetworkServiceProtocol {
    func data<T: NetworkingRequest>(_ request: T) -> AnyPublisher<Data, NetworkError>
    func json<T: NetworkingRequest>(_ request: T) -> AnyPublisher<T.ResponseType, NetworkError>
}
