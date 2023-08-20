import SwiftUI
import MapKit

final class RouteMapViewModel: ObservableObject {
    @Published private(set) var region: MKCoordinateRegion?
    @Published private(set) var points: [MKPointAnnotation] = []
    let from: CLLocationCoordinate2D
    let to: CLLocationCoordinate2D

    init(from: LocationCoordinates, to: LocationCoordinates) {
        self.from = CLLocationCoordinate2D(latitude: from.lat, longitude: from.long)
        self.to = CLLocationCoordinate2D(latitude: to.lat, longitude: to.long)
        setupMap()
    }

    private func setupMap() {
        let centerLatitude = to.latitude
        let centerLongitude = to.longitude
        let meters: Double = 1000 * 1000
        region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: centerLatitude,
                longitude: centerLongitude
            ),
            latitudinalMeters: meters,
            longitudinalMeters: meters
        )
        points = [from, to].map {
            let point = MKPointAnnotation()
            point.coordinate = $0
            return point
        }
    }
}
