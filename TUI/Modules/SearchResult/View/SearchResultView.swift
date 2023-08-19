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
                if viewModel.query.isEmpty {
                    SearchResultItem(item: viewModel.selected) {
                        dismiss()
                    }
                    .padding(.horizontal, .x3)
                    Spacer()
                } else if viewModel.result.isEmpty {
                    NotFoundView()
                        .frame(maxHeight: .infinity)
                    Spacer()
                } else {
                    List(viewModel.result, id: \.self) { item in
                        SearchResultItem(item: item) {
                            viewModel.selected = item
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}
