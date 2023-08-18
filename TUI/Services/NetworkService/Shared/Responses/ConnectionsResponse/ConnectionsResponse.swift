import Foundation

// MARK: - Connections

struct ConnectionsResponse: Codable {
    let connections: [Connection]
}

// MARK: - Connection

struct Connection: Codable {
    let from, to: String
    let coordinates: Coordinates
    let price: Int
}

// MARK: - Coordinates

struct Coordinates: Codable {
    let from, to: From
}

// MARK: - From

struct From: Codable {
    let lat, long: Double
}
