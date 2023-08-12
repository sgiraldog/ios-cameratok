import SwiftUI

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        SecondaryButtonStyleView(configuration: configuration)
    }
}

extension SecondaryButtonStyle {
    struct SecondaryButtonStyleView: View {
        let configuration: SecondaryButtonStyle.Configuration
        
        var body: some View {
            configuration.label
                .foregroundColor(Color(.label))
                .background(Color(.systemBackground))
                .opacity(configuration.isPressed ? Constants.pressedOpacity : Constants.defaultOpacity)
                .cornerRadius(Constants.cornerRadius)
        }
    }
}

private extension SecondaryButtonStyle {
    enum Constants {
        static let cornerRadius: CGFloat = 14
        static let pressedOpacity: CGFloat = 0.8
        static let defaultOpacity: CGFloat = 1.0
    }
}
