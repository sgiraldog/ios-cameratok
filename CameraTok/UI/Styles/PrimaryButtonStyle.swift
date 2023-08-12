import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        PrimaryButtonStyleView(configuration: configuration)
    }
}

extension PrimaryButtonStyle {
    struct PrimaryButtonStyleView: View {
        let configuration: PrimaryButtonStyle.Configuration
        
        var body: some View {
            configuration.label
                .foregroundColor(Color(UIColor.systemBackground))
                .background(Color(UIColor.label))
                .opacity(configuration.isPressed ? Constants.pressedOpacity : Constants.defaultOpacity)
                .cornerRadius(Constants.cornerRadius)
        }
    }
}

private extension PrimaryButtonStyle {
    enum Constants {
        static let cornerRadius: CGFloat = 14
        static let pressedOpacity: CGFloat = 0.8
        static let defaultOpacity: CGFloat = 1.0
    }
}
