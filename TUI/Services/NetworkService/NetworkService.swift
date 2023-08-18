import Foundation
import Combine

final class NetworkService: NetworkServiceProtocol {
    private let queue: DispatchQueue = .init(
        label: String(describing: "com.apple.networkService.queue"),
        qos: .background
    )

    func data<T: NetworkingRequest>(_ request: T) -> AnyPublisher<Data, NetworkError> {
        return Future<Data, NetworkError> { [weak self] promise in
            guard let self else {
                promise(.failure(.invalidError))
                return
            }

            guard let urlRequest = try? self.createUrlRequest(request) else {
                promise(.failure(.badRequest))
                return
            }

            URLSession(configuration: .default).dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    promise(.failure(.custom(error)))
                    return
                }
                if let data = data {
                    promise(.success(data))
                }
            }.resume()
        }.eraseToAnyPublisher()
    }

    func json<T: NetworkingRequest>(_ request: T) -> AnyPublisher<T.ResponseType, NetworkError> {
        return data(request)
            .tryMap {
                let object = try JSONDecoder().decode(T.ResponseType.self, from: $0)
                return object
            }
            .mapError({ NetworkError.custom($0) })
            .eraseToAnyPublisher()
    }

    // MARK: - Instance Methods

    private func createUrlRequest<T: NetworkingRequest>(_ request: T) throws -> URLRequest {
        let requestDescriptor = request.getRequestDescriptor()
        let url = requestDescriptor.baseUrl
            .appendingPathComponent(requestDescriptor.prefix)
            .appendingPathComponent(requestDescriptor.path)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requestDescriptor.method.rawValue
        urlRequest = applyAdapter(urlRequest, requestDescriptor: requestDescriptor)
        urlRequest = try requestDescriptor.encoding.encode(urlRequest, with: requestDescriptor.params)
        return urlRequest
    }

    private func applyAdapter(
        _ urlRequest: URLRequest,
        requestDescriptor: RequestDescriptor
    ) -> URLRequest {
        var urlRequest = urlRequest
        urlRequest.allHTTPHeaderFields = requestDescriptor.headers
        return urlRequest
    }

}
