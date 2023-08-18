import SwiftUI

struct SearchResultView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel: SearchResultViewModel
    let title: Localization
    

    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea(.all)
            VStack(spacing: 0) {
                TextField(title.value, text: $viewModel.query)
                    .modifier(BasicTextField(value: $viewModel.query))
                    .padding(.horizontal, .x3)
                Divider()
                List(viewModel.result, id: \.self) { item in
                    SearchResultItem(item: item, action: {
                        viewModel.selected = item
                        dismiss()
                    })
                }
            }
        }
    }
}
