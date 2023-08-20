import CoreLocation

final class LocationManager: NSObject, LocationManagerProtocol, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    private var locationPromise: CheckedContinuation<String?, Never>?

    func getCurrentLocation() async -> String? {
        await withCheckedContinuation { (continuation: CheckedContinuation<String?, Never>) in
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
            manager.requestWhenInUseAuthorization()
            checkLocationAuthorization()
            locationPromise = continuation
        }
    }

    private func mapToCity(_ location: CLLocation) async -> String? {
        let geoCoder = CLGeocoder()
        guard let placemarks = try? await geoCoder.reverseGeocodeLocation(location),
              let placemark = placemarks.first,
              let city = placemark.locality
        else { return nil }
        return city
    }

    private func checkLocationAuthorization() {
        switch manager.authorizationStatus{
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
        default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        Task {
            let city = await mapToCity(location)
            if let promise = locationPromise {
                locationPromise = nil
                promise.resume(returning: city)
            }
        }
    }
}
