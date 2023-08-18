import SwiftUI

struct IconView: View {
    var name: IconName
    var fontSize: CGFloat = .x2
    var weight: Font.Weight = .regular
    var color: Color?
    
    var body: some View {
        if let color = color {
            image.foregroundColor(color)
        } else {
            image
        }
    }
}

// MARK: - Build method

private extension IconView {
    @ViewBuilder var image: some View {
        Image(systemName: name.rawValue).font(.system(size: fontSize, weight: weight))
    }
}
