import UIKit

class VideosCoordinator: NavigatedCoordinator {
    var navigationController: UINavigationController
    
    init() {
        navigationController = .init()
    }
    
    func start() {
        let rootViewController = VideoGalleryViewController(coordinator: self)
        navigationController.setViewControllers([rootViewController], animated: false)
    }
    
    func navigateToVideoPlayer(videos: [VideoInfo], selectedVideo: Int) {
        let videoListViewController = VideoPlayerViewController(coordinator: self, videos: videos, selectedVideo: selectedVideo)
        navigationController.pushViewController(videoListViewController, animated: true)
    }
}
