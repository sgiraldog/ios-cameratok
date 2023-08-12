import SwiftUI

struct SecondaryButton: View {
    
    public let title: String?
    public let icon: UIImage?
    public var onClick: (() -> Void)
    
    init(
        title: String? = nil,
        icon: UIImage? = nil,
        onClick: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self.onClick = onClick
    }
    
    var body: some View {
        Button(action: onClick) {
            HStack(spacing: Constants.itemSpacing) {
                if let icon = icon {
                    Image(uiImage: icon)
                        .resizable()
                        .frame(
                            width: Constants.iconSize,
                            height: Constants.iconSize
                        )
                        .foregroundColor(Color(uiColor: .label))
                }
                
                if let title = title {
                    Text(title)
                        .font(.system(size: Constants.labelTextSize, weight: .bold))
                }
            }
            .padding()
        }
        .buttonStyle(SecondaryButtonStyle())
    }
}

private extension SecondaryButton {
    enum Constants {
        static let labelTextSize: CGFloat = 17
        static let itemSpacing: CGFloat = 12
        static let iconSize: CGFloat = 20
    }
}

struct SecondaryButton_Previews: PreviewProvider {
    static var previews: some View {
        SecondaryButton(title: "Secondary Button", onClick: {})
            .padding()
    }
}
