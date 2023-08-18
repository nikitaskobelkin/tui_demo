import SwiftUI

struct SearchResultItem: View {
    let item: String
    let action: () -> Void

    var body: some View {
        HStack(spacing: .x3) {
            IconView(name: .airplane, color: .gray)
            Button(item) {
                action()
            }
            Spacer()
        }
        .modifier(CityItem())
    }
}
