import SwiftUI

final class SearchResultViewModel: ObservableObject {
    @Published var query: String = ""
    @Binding var selected: String
    private let cities: [String]

    init(selected: Binding<String>, cities: [String]) {
        self.query = ""
        self._selected = selected
        self.cities = cities
    }

    var result: [String] {
        if query.isEmpty {
            return cities
        }
        return cities.filter { $0.lowercased().contains(query.lowercased()) }
    }
}
