import Foundation
@testable import TUI

struct TestConstants {
    enum MockError: Error {
        case failureError
    }

    enum TestError: String {
        case failureConnection = "Incorrect response from fetching"
    }

    static let mockJSON: String = """
        {
          "connections": [
            {
              "from": "London",
              "to": "Tokyo",
              "coordinates": {
                "from": {
                  "lat": 51.5285582,
                  "long": -0.241681
                },
                "to": {
                  "lat": 35.652832,
                  "long": 139.839478
                }
              },
              "price": 220
            },
            {
              "from": "London",
              "to": "Tokyo",
              "coordinates": {
                "from": {
                  "lat": 51.5285582,
                  "long": -0.241681
                },
                "to": {
                  "lat": 35.652832,
                  "long": 139.839478
                }
              },
              "price": 100
            },
            {
              "from": "London",
              "to": "Porto",
              "price": 50,
              "coordinates": {
                "from": {
                  "lat": 51.5285582,
                  "long": -0.241681
                },
                "to": {
                  "lat": 41.14961,
                  "long": -8.61099
                }
              }
            }
          ]
        }
    """

    static let mockConnectionsQuantity: Int = 3
    static let currentLocation: String = "Porto"
    static let cheapest: Connection = Connection(
        from: "London",
        to: "Tokyo",
        coordinates: Coordinates(
            from: LocationCoordinates(lat: 51.5285582, long: -0.241681),
            to: LocationCoordinates(lat: 35.652832, long: 139.839478)
        ),
        price: 100
    )
}
