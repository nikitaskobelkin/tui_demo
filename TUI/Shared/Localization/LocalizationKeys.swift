import SwiftUI

enum Localization: String {
    case from
    case to
    case showButtonTitle
}

// MARK: - Localization value

extension Localization {
    var value: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}
