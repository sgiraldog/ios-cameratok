import SwiftUI
import AVKit

struct VideoPlayerView: View {
    @ObservedObject var viewModel: VideoPlayerViewModel
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .topLeading) {
                pagedVideoList(proxy: proxy)
                backButton
            }
        }
        .onAppear(perform: viewModel.onAppear)
        .onDisappear(perform: viewModel.onDisappear)
    }
    
    var backButton: some View {
        SecondaryButton(
            icon: UIImage(systemName: Constants.backButtonIconName),
            onClick: viewModel.goBack
        )
        .environment(\.colorScheme, .light)
        .padding(.horizontal)
    }
    
    func pagedVideoList(proxy: GeometryProxy) -> some View {
        TabView(selection: $viewModel.currentVideoIndex) {
            ForEach(Array(viewModel.players.enumerated()), id: \.offset) { index, player in
                videoPlayer(
                    player: player,
                    index: index
                )
            }
            .rotationEffect(.degrees(-Constants.rotationDegrees))
            .frame(
                width: proxy.size.width,
                height: proxy.size.height
            )
        }
        .frame(
            width: proxy.size.height,
            height: proxy.size.width
        )
        .rotationEffect(
            .degrees(Constants.rotationDegrees),
            anchor: .topLeading
        )
        .offset(x: proxy.size.width)
        .tabViewStyle(
            PageTabViewStyle(indexDisplayMode: .never)
        )
    }
    
    func videoPlayer(player: AVPlayer?, index: Int) -> some View  {
        ZStack(alignment: .bottomTrailing) {
            VideoPlayer(player: player)
                .onAppear {
                    viewModel.startPlayer(at: index)
                }
                .onDisappear {
                    viewModel.stopPlayer(at: index)
                }
            Color.gray
                .opacity(Constants.videoOverlayOpacity)
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity
                )
                .onTapGesture {
                    withAnimation {
                        viewModel.showControls.toggle()
                    }
                }
            
            if viewModel.showControls {
                CustomVideoControlsView(
                    progress: $viewModel.currentVideoProgress,
                    isSliderMoving: $viewModel.blockVideoPlayback,
                    isMuted: $viewModel.isMuted,
                    onTapMute: {
                        viewModel.updateMuteStatus()
                    }
                )
                .padding()
                .padding(
                    .bottom,
                    Constants.customVideoControlSpacing
                )
                .onChange(of: viewModel.blockVideoPlayback) { _ in
                    viewModel.sliderDidUpdatePlayback()
                }
            }
            
            VideoInteractionView(
                viewModel: .init(liked: viewModel.videos[index].liked),
                onLike: {
                    viewModel.updateVideoLikeStatus(for: index, liked: true)
                },
                onDislike: {
                    viewModel.updateVideoLikeStatus(for: index, liked: false)
                }
            )
            .padding()
            .padding(
                .bottom,
                Constants.videoInteractionSpacing
            )
        }
    }
}

private extension VideoPlayerView {
    enum Constants {
        static let rotationDegrees: CGFloat = 90
        static let backButtonIconName = "chevron.left.circle.fill"
        static let videoOverlayOpacity: CGFloat = 0.01
        static let customVideoControlSpacing: CGFloat = 40
        static let videoInteractionSpacing: CGFloat = 140
    }
}

struct VideoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerView(viewModel: .init(coordinator: .init(), videos: []))
    }
}
