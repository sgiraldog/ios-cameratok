import SwiftUI

struct VideoInteractionView: View {
    @ObservedObject var viewModel: ViewModel
    var onLike: (() -> Void)
    var onDislike: (() -> Void)
    
    var body: some View {
        VStack {
            SecondaryButton(
                icon: UIImage(
                    systemName: viewModel.videoLikeStatus == .liked ? Constants.likeIconFilled : Constants.likeIcon
                ),
                onClick: onLike
            )
            .environment(\.colorScheme, .light)
            .padding()
            
            SecondaryButton(
                icon: UIImage(
                    systemName: viewModel.videoLikeStatus == .disliked ? Constants.dislikeIconFilled : Constants.dislikeIcon
                ),
                onClick: onDislike
            )
            .environment(\.colorScheme, .light)
            .padding()
        }
        .background(Color.white)
        .cornerRadius(Constants.likeButtonCornerRadius)
    }
}

extension VideoInteractionView {
    enum VideoLikeStatus {
        case liked
        case none
        case disliked
    }
    final class ViewModel: ObservableObject {
        @Published var liked: Bool?
        
        init(
            liked: Bool?
        ) {
            self.liked = liked
        }
        
        var videoLikeStatus: VideoLikeStatus {
            if let liked = liked {
                return liked ? .liked : .disliked
            } else {
                return .none
            }
        }
    }
}

private extension VideoInteractionView {
    enum Constants {
        static let menuWidth: CGFloat = 16
        static let likeButtonCornerRadius: CGFloat = 12
        static let likeIcon = "hand.thumbsup"
        static let dislikeIcon = "hand.thumbsdown"
        static let likeIconFilled = "hand.thumbsup.fill"
        static let dislikeIconFilled = "hand.thumbsdown.fill"
    }
}

struct VideoInteractionView_Previews: PreviewProvider {
    static var previews: some View {
        VideoInteractionView(
            viewModel: .init(liked: false),
            onLike: {},
            onDislike: {}
        )
    }
}
