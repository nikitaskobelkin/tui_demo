import SwiftUI

struct WelcomeViewBuilder {
    static func build() -> some View {
        let viewModel = WelcomeViewModel()
        return WelcomeView(viewModel: viewModel)
    }
}
