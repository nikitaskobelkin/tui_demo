import SwiftUI

struct SearchResultViewBuilder {
    static func build(selected: Binding<String>, cities: [String], title: Localization) -> some View {
        let viewModel = SearchResultViewModel(selected: selected, cities: cities)
        return SearchResultView(viewModel: viewModel, title: title)
    }
}
