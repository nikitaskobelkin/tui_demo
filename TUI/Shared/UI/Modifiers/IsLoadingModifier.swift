import SwiftUI

// MARK: - View's methods

extension View {
    @ViewBuilder func isLoading(_ isLoading: Bool) -> some View {
        self.modifier(IsLoadingModifier(isLoading: isLoading))
    }
}

// MARK: - Implementation Modifiers

private struct IsLoadingModifier: ViewModifier {
    var isLoading: Bool

    func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(isLoading)
                .opacity(isLoading ? 0.8 : 1)
            if isLoading {
                ProgressView()
            }
        }
    }
}
