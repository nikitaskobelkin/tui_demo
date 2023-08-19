import SwiftUI

struct Map: ViewModifier {
    var minHeight: CGFloat = .x3 * 10
    var maxWidth: CGFloat = .infinity

    func body(content: Content) -> some View {
        content
            .frame(maxWidth: maxWidth, minHeight: minHeight)
            .cornerRadius(.x)
    }
}
