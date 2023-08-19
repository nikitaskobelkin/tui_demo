import SwiftUI
import CoreLocation

struct RouteResultView: View {
    let route: Connection?

    var body: some View {
        VStack(spacing: .x3) {
            Text(Localization.cheapestTitle.value)
                .modifier(FontBody())
            VStack(spacing: .x2) {
                if let route {
                    HStack {
                        Text(route.from)
                        Spacer()
                        IconView(name: .airplane, weight: .regular, color: .gray)
                        Spacer()
                        Text(route.to)
                    }
                    .modifier(FontBody(size: .x3, weight: .semibold))
                    Divider()
                    Text("\(Localization.price.value): \(route.price)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .modifier(FontBody(weight: .semibold))
                    RouteMapView(
                        viewModel: RouteMapViewModel(
                            from: route.coordinates.from,
                            to: route.coordinates.to
                        )
                    )
                } else {
                    NotFoundView()
                        .frame(maxWidth: .infinity)
                }
            }
            .modifier(Block())
        }
    }
}
