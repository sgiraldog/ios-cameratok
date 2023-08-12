import SwiftUI

struct IntroView: View {
    @ObservedObject var viewModel: IntroViewModel
    
    init(coordinator: IntroCoordinator) {
        self.viewModel = .init(coordinator: coordinator)
    }
    
    var body: some View {
        VStack(spacing: Constants.itemsSpacing) {
            Spacer()
            Image(uiImage: Asset.introIcon.image)
                .resizable()
                .frame(
                    width: Constants.iconSize,
                    height: Constants.iconSize
                )
                .foregroundColor(.blue)
                .cornerRadius(Constants.iconCornerRadius)
            
            Text(L10n.Intro.title)
                .font(.largeTitle)
            
            Text(L10n.Intro.body)
                .font(.body)
            
            Spacer()
            
            PrimaryButton(
                title: L10n.Intro.Button.title,
                onClick: viewModel.completeIntro
            )
            .frame(maxWidth: .infinity)
            
            Text(L10n.Intro.PermissionDenied.label)
                .font(.caption)
                .foregroundColor(.red)
                .opacity(viewModel.permissionsDenied ? 1 : 0)
        }
        .padding()
    }
}

private extension IntroView {
    enum Constants {
        static let itemsSpacing: CGFloat = 32
        static let iconSize: CGFloat = 60
        static let iconCornerRadius: CGFloat = 12
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView(coordinator: .init())
    }
}
