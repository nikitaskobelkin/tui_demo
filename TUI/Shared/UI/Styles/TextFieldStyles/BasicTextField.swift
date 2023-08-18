import SwiftUI

struct BasicTextField: ViewModifier {
    @Binding var value: String
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: .x2, weight: .regular))
            .foregroundColor(.text)
            .accentColor(Color.cyan)
            .padding(.vertical, .x2)
            .overlay {
                HStack {
                    Spacer()
                    if !value.isEmpty {
                        Button(action: { value.removeAll() }) {
                            IconView(name: .xmark_circle_fill, color: .gray)
                        }
                    }
                }
            }
    }
}
