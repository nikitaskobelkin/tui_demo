import Foundation

final class ConnectionsManager: ConnectionsManagerProtocol {
    @Dependency(\.networkService) private var networkService

    func fetchConnections() async -> Result<ConnectionsResponse, NetworkError> {
        let request = ConnectionsRequest()
        return await networkService.json(request).async()
    }
}
