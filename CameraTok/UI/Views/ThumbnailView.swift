import SwiftUI

struct ThumbnailView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    init(
        viewModel: ViewModel
    ) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Image(uiImage: viewModel.image)
                .resizable()
                .frame(
                    width: viewModel.imageWidth,
                    height: viewModel.imageHeight
                )
            
            if viewModel.isVideoLiked {
                SecondaryButton(
                    icon: UIImage(systemName: Constants.likeIconName),
                    onClick: {}
                )
                .environment(\.colorScheme, .light)
                .disabled(true)
                .padding(.all, Constants.likeIconSpacing)
            }
        }
        .cornerRadius(Constants.cornerRadius)
    }
}

extension ThumbnailView {
    final class ViewModel: ObservableObject {
        @Published var liked: Bool?
        let image: UIImage
        let imageWidth: CGFloat
        let imageHeight: CGFloat
        
        init(
            liked: Bool?,
            image: UIImage,
            imageWidth: CGFloat,
            imageHeight: CGFloat
        ) {
            self.liked = liked
            self.image = image
            self.imageWidth = imageWidth
            self.imageHeight = imageHeight
        }
        
        var isVideoLiked: Bool {
            return liked ?? false
        }
    }
}

private extension ThumbnailView {
    enum Constants {
        static let cornerRadius: CGFloat = 12
        static let likeIconSpacing: CGFloat = 4
        static let likeIconName = "hand.thumbsup.fill"
    }
}

struct VideoThumbnail_Previews: PreviewProvider {
    static var previews: some View {
        ThumbnailView(viewModel: .init(liked: false, image: .init(), imageWidth: .infinity, imageHeight: .infinity))
    }
}
