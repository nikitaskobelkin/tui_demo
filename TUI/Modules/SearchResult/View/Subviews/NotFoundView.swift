import SwiftUI

struct NotFoundView: View {
    var body: some View {
        VStack(spacing: .x2) {
            IconView(name: .airplane, fontSize: .x4, color: .pink)
            Text(Localization.notFound.value)
                .modifier(FontBody(weight: .semibold))
        }
    }
}
