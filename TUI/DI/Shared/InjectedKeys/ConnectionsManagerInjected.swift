import Foundation

extension InjectedValues {
    var connectionsManager: ConnectionsManagerProtocol {
        get { Self[ConnectionManagerKey.self] }
        set { Self[ConnectionManagerKey.self] = newValue }
    }
}

private struct ConnectionManagerKey: InjectionKey {
    static var currentValue: ConnectionsManagerProtocol = ConnectionsManager()
}
