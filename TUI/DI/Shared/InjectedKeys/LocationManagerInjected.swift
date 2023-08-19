import Foundation

extension InjectedValues {
    var locationManager: LocationManagerProtocol {
        get { Self[LocationManagerKey.self] }
        set { Self[LocationManagerKey.self] = newValue }
    }
}

private struct LocationManagerKey: InjectionKey {
    static var currentValue: LocationManagerProtocol = LocationManager()
}
