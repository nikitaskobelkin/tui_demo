import SwiftUI

struct Block: ViewModifier {
    func body(content: Content) -> some View {
        content
            .modifier(FontBody())
            .padding(.horizontal, .x3)
            .padding(.vertical, .x2)
            .background(Color.hightlight)
            .cornerRadius(.x3)
    }
}
