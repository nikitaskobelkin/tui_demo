import SwiftUI

struct PointButtonView: View {
    let title: Localization
    let text: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: .x) {
                Text(title.value)
                    .modifier(FontLabel())
                Text(text)
                    .modifier(FontBody())
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
