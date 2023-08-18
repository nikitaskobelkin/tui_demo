import SwiftUI

struct FontLabel: ViewModifier {
    private var size: CGFloat = 12
    var weight: Font.Weight = .regular

    func body(content: Content) -> some View {
        content
            .font(.system(size: size, weight: weight))
            .foregroundColor(.gray)
    }
}
