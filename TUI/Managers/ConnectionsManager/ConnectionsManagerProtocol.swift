import Foundation

protocol ConnectionsManagerProtocol {
    func fetchConnections() async -> Result<ConnectionsResponse, NetworkError>
}
