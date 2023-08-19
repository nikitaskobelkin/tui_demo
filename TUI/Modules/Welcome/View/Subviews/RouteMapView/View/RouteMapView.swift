import SwiftUI
import MapKit

struct Location: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

struct RouteMapView: View {
    @ObservedObject var viewModel: RouteMapViewModel

    var body: some View {
        MapView(
            fromCoordinate: viewModel.from,
            toCoordinate: viewModel.to,
            region: viewModel.region,
            points: viewModel.points
        )
        .modifier(Map())
    }
}
