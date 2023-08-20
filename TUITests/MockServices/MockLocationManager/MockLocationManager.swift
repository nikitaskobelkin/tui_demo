import Foundation
@testable import TUI

final class MockLocationManager: LocationManagerProtocol {
    private let currentLocation: String

    init(_ location: String) {
        currentLocation = location
    }

    func getCurrentLocation() async -> String? {
        return currentLocation
    }
}
