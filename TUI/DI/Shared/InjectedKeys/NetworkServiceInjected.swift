import Foundation

extension InjectedValues {
    var networkService: NetworkServiceProtocol {
        get { Self[NetworkServiceKey.self] }
        set { Self[NetworkServiceKey.self] = newValue }
    }
}

private struct NetworkServiceKey: InjectionKey {
    static var currentValue: NetworkServiceProtocol = NetworkService()
}
