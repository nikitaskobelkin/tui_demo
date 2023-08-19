import SwiftUI

final class WelcomeViewModel: ObservableObject {
    @Dependency(\.connectionsManager) private var connectionsManager
    @Dependency(\.locationManager) private var locationManager
    @Published private(set) var cities: [String] = []
    @Published var from: String = ""
    @Published var to: String = ""
    @Published var isLoading: Bool = false
    @Published var cheapest: Connection?
    @Published var shouldShowResult: Bool = false

    func fetchData() {
        isLoading = true
        Task { @MainActor in
            defer { isLoading = false }
            let connections = await fetchConnections()
            cities = Array(Set(connections.flatMap({ [$0.from, $0.to] }))).sorted(by: { $0 < $1 })
            if let currentLocation = await locationManager.getCurrentLocation(),
               let newFrom = cities.first(where: { $0.lowercased() == currentLocation.lowercased() }) {
                from = newFrom
            } else {
                from = cities.randomElement() ?? ""
            }
            to = cities.filter({ $0 != from }).randomElement() ?? ""
        }
    }

    func findCheapest() {
        isLoading = true
        Task { @MainActor in
            defer {
                shouldShowResult = true
                isLoading = false
            }
            let connections = await fetchConnections()
            cheapest = connections.filter({ $0.from == from && $0.to == to }).min(by: { $0.price < $1.price })
        }
    }

    func swap() {
        Swift.swap(&from, &to)
    }

    private func fetchConnections() async -> [Connection] {
        let connectionsResponse = await connectionsManager.fetchConnections()
        switch connectionsResponse {
        case .success(let response):
            return response.connections
        default:
            return []
        }
    }
}
