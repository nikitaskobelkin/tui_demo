import Foundation

struct ConnectionsRequest: NetworkingRequest {
    typealias ResponseType = ConnectionsResponse

    func getRequestDescriptor() -> RequestDescriptor {
        RequestDescriptor(
            baseUrl: NetworkConstants.baseURL,
            path: NetworkConstants.Endpoint.connections.rawValue,
            method: .get,
            encoding: .url
        )
    }
}
