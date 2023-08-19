import SwiftUI

struct WelcomeView: View {
    @State private var searchType: SearchType?
    @StateObject private var viewModel = WelcomeViewModel()

    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea(.all)
            ScrollView {
                VStack(spacing: .x4) {
                    VStack(spacing: .x2) {
                        HStack(spacing: .x2) {
                            VStack(alignment: .leading, spacing: .x2) {
                                PointButtonView(
                                    title: SearchType.from.title,
                                    text: viewModel.from,
                                    action: {
                                        searchType = .from
                                    }
                                )
                                PointButtonView(
                                    title: SearchType.to.title,
                                    text: viewModel.to,
                                    action: {
                                        searchType = .to
                                    }
                                )
                            }
                            Spacer()
                            Button(action: viewModel.swap) {
                                IconView(name: .arrow_up_arrow_down, fontSize: .x3)
                            }
                        }
                        Button(Localization.showButtonTitle.value) {
                            viewModel.findCheapest()
                        }
                        .buttonStyle(PrimaryButton(maxWidth: .infinity))
                    }
                    .frame(maxWidth: .infinity)
                    .modifier(Block())
                    if viewModel.shouldShowResult {
                        RouteResultView(route: viewModel.cheapest)
                            .isLoading(viewModel.isLoading)
                    }
                    Spacer()
                }
                .padding(.all, .x2)
            }
            .sheet(item: $searchType) { type in
                SearchResultView(
                    viewModel: SearchResultViewModel(
                        selected: type == .from ? $viewModel.from : $viewModel.to,
                        cities: viewModel.cities
                    ),
                    title: type.title
                )
            }
            .onAppear {
                viewModel.fetchData()
            }
            .isLoading(viewModel.isLoading)
        }
    }
}
