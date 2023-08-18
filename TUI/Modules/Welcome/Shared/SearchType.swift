import Foundation

enum SearchType: Identifiable {
    case from
    case to
}

extension SearchType {
    var id: UUID {
        UUID()
    }

    var title: Localization {
        switch self {
        case .from: return .from
        case .to: return .to
        }
    }
}
