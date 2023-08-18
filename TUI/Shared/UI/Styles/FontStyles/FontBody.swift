import SwiftUI

struct FontBody: ViewModifier {
    var size: CGFloat = .x2
    var color: Color = .text
    var weight: Font.Weight = .regular

    func body(content: Content) -> some View {
        content
            .font(.system(size: size, weight: weight))
            .foregroundColor(color)
    }
}
