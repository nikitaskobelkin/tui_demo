import SwiftUI

struct CityItem: ViewModifier {
    func body(content: Content) -> some View {
        content
            .modifier(FontBody())
            .padding(.vertical, .x2)
    }
}
