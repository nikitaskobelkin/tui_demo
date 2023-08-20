import SwiftUI
import MapKit

struct RouteMapViewBuilder {
    static func build(from: LocationCoordinates, to: LocationCoordinates) -> some View {
        let viewModel = RouteMapViewModel(from: from, to: to)
        return RouteMapView(viewModel: viewModel)
    }
}
