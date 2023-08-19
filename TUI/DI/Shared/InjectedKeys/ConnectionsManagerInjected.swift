import Foundation

extension InjectedValues {
    var connectionsManager: ConnectionsManagerProtocol {
        get { Self[ConnectionsManagerKey.self] }
        set { Self[ConnectionsManagerKey.self] = newValue }
    }
}

private struct ConnectionsManagerKey: InjectionKey {
    static var currentValue: ConnectionsManagerProtocol = ConnectionsManager()
}
