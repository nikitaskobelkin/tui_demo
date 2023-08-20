import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    let fromCoordinate: CLLocationCoordinate2D
    let toCoordinate: CLLocationCoordinate2D
    let region: MKCoordinateRegion?
    let points: [MKPointAnnotation]

    func makeUIView(context: UIViewRepresentableContext<Self>) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        setupData(mapView)
        addOverlays(mapView)
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: UIViewRepresentableContext<Self>) {
        setupData(view)
        addOverlays(view)
        view.delegate = context.coordinator
    }

    private func addOverlays(_ view: MKMapView) {
        let points = [fromCoordinate, toCoordinate]
        let polygon = MKPolygon(coordinates: points, count: points.count)
        if !view.overlays.isEmpty {
            view.removeOverlays(view.overlays)
        }
        view.addOverlay(polygon)
    }

    private func setupData(_ view: MKMapView) {
        if let region = region {
            view.region = region
        }
        view.removeAnnotations(view.annotations)
        view.addAnnotations(points)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        let parent: MapView
        init(_ parent: MapView) {
            self.parent = parent
            super.init()
        }

        func mapView(_: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.fillColor = UIColor.cyan
            renderer.strokeColor = UIColor.cyan
            return renderer
        }
    }
}
