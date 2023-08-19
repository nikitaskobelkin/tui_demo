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
        let span = MKCoordinateSpan(
            latitudeDelta: abs(to.latitude - from.latitude) * .x * 0.3,
            longitudeDelta: abs(to.longitude - from.longitude) * .x * 0.3
        )
        region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: centerLatitude,
                longitude: centerLongitude
            ),
            span: span
        )
        points = [from, to].map {
            let point = MKPointAnnotation()
            point.coordinate = $0
            return point
        }
    }
}
