import SwiftUI

// MARK: - Primary Button Style

struct PrimaryButton: ButtonStyle {
    var minWidth: CGFloat?
    var maxWidth: CGFloat?
    var verticalPadding: CGFloat = .x2

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.system(size: .x2, weight: .semibold))
            .frame(minWidth: minWidth ?? .none, maxWidth: maxWidth ?? .none)
            .padding(.vertical, verticalPadding)
            .padding(.horizontal, .x5)
            .foregroundColor(.black)
            .background(.cyan)
            .cornerRadius(.x)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .animation(.spring(), value: configuration.isPressed)
    }
}
