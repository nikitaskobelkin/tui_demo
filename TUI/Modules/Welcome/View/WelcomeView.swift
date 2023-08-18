import SwiftUI

struct WelcomeView: View {
    @State private var searchType: SearchType?
    @StateObject private var viewModel = WelcomeViewModel()

    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea(.all)
            ScrollView {
                VStack {
                    VStack(spacing: .x2) {
                        HStack(spacing: .x2) {
                            VStack(alignment: .leading, spacing: .x2) {
                                PointButtonView(
                                    title: SearchType.from.title,
                                    text: viewModel.first,
                                    action: {
                                        searchType = .from
                                    }
                                )
                                PointButtonView(
                                    title: SearchType.to.title,
                                    text: viewModel.first,
                                    action: {
                                        searchType = .to
                                    }
                                )
                            }
                            Spacer()
                            Button(action: {}) {
                                IconView(name: .arrow_up_arrow_down, fontSize: .x3)
                            }
                        }
                        Button("Show cheapest") {
                            // TODO: 
                        }
                        .buttonStyle(PrimaryButton(maxWidth: .infinity))
                    }
                    .frame(maxWidth: .infinity)
                    .modifier(Block())
                    .padding(.all, .x2)
                    Spacer()
                }
            }
            .sheet(item: $searchType) { type in
                SearchResultView(
                    viewModel: SearchResultViewModel(selected: $viewModel.first, cities: viewModel.cities),
                    title: type.title
                )
            }
            .onAppear {
                viewModel.fetchData()
            }
        }
    }
}
