import Foundation

enum ParameterEncoding {
    case url
    case json

    func encode(_ request: URLRequest, with parameters: [String: Any]?) throws -> URLRequest {
        var mutableRequest = request

        switch self {
        case .url:
            guard let parameters = parameters else { return mutableRequest }
            if var components = URLComponents(url: mutableRequest.url!, resolvingAgainstBaseURL: false) {
                components.queryItems = parameters.map { key, value in
                    URLQueryItem(name: key, value: "\(value)")
                }
                mutableRequest.url = components.url
            }
        case .json:
            guard let parameters = parameters else { return mutableRequest }
            do {
                mutableRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                mutableRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            } catch {
                throw error
            }
        }

        return mutableRequest
    }
}
