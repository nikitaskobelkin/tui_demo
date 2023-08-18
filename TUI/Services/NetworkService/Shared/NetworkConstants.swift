import Foundation

struct NetworkConstants {
    static let baseURL: URL = URL(string: "https://raw.githubusercontent.com/TuiMobilityHub/ios-code-challenge/master/")!

    enum Endpoint: String {
        case connections = "connections.json"
    }
}
