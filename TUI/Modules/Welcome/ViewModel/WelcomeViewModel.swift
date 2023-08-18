import SwiftUI

final class WelcomeViewModel: ObservableObject {
    @Dependency(\.connectionsManager) private var connectionsManager
    @Published var first: String = ""
    @Published var second: String = ""
    @Published var isLoading: Bool = false
    @Published private(set) var cities: [String] = []

    func fetchData() {
        isLoading = true
        Task { @MainActor in
            defer { isLoading = false }
            let connectionsResponse = await connectionsManager.fetchConnections()
            switch connectionsResponse {
            case .success(let connections):
                cities = Array(Set(connections.connections.flatMap({ [$0.from, $0.to] })))
                first = cities.first ?? ""
            default:
                return
            }
        }
    }
}
