import UIKit
import SwiftUI

class VideoPlayerViewController: UIHostingController<VideoPlayerView> {
    init(
        coordinator: VideosCoordinator,
        videos: [VideoInfo],
        selectedVideo: Int
    ) {
        super.init(
            rootView: VideoPlayerView(
                viewModel: .init(
                    coordinator: coordinator,
                    videos: videos,
                    selectedVideo: selectedVideo
                )
            )
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        navigationController?.isNavigationBarHidden = false
        overrideUserInterfaceStyle = .dark 
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
