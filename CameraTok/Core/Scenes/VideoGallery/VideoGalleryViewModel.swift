import Foundation
import Combine

class VideoGalleryViewModel: ObservableObject {
    @Published var videos: [VideoInfo] = []
    @Published var date: Date = .now
        
    private let coordinator: VideosCoordinator
    private let service = VideoService()
    private var cancellables = Set<AnyCancellable>()
    private var lastVideoDate: Date = .now
    private var isLoading = false
    private var reachedEndOfVideos = false
    private var thumbnailWidth: CGFloat = 0
    
    var filteredVideos: [VideoInfo] {
        videos
            .filter({ $0.liked != false })
            .sorted { $0.date > $1.date }
    }
    
    init(coordinator: VideosCoordinator) {
        self.coordinator = coordinator
    }
    
    func onAppear(thumbnailWidth: CGFloat) {
        if videos.isEmpty {
            self.thumbnailWidth = thumbnailWidth
            fetchVideos()
        } else {
            updateVideosLikedStatus()
        }
    }
    
    private func updateVideosLikedStatus() {
        let videosStatus = service.getVideosLikedState()
        
        videos = videos.map { video in
            var newVideo = video
            if let videoStatus = videosStatus.first(where: { $0.id == video.id }) {
                newVideo.liked = videoStatus.liked
            }
            return newVideo
        }
    }
    
    func selectedDateChanged() {
        lastVideoDate = date
        fetchVideos()
    }
    
    func fetchVideos(appendVideos: Bool = false) {
        isLoading = true
        service.getVideos(before: lastVideoDate, width: thumbnailWidth)
            .sink { [weak self] videos in
                DispatchQueue.main.async {
                    if appendVideos {
                        self?.videos.append(contentsOf: videos)
                        self?.reachedEndOfVideos = videos.isEmpty
                    } else {
                        self?.videos = videos
                        self?.reachedEndOfVideos = false
                    }
                    if let lastVideo = videos.last {
                        self?.lastVideoDate = lastVideo.date
                    }
                }
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }
    
    func fetchMoreVideosIfNeeded(index: Int) {
        guard !isLoading else { return }
        
        if index == videos.count - 1 && !reachedEndOfVideos {
            fetchVideos(appendVideos: true)
        }
    }
    
    func navigateToVideos(selectedVideo: Int) {
        coordinator.navigateToVideoPlayer(videos: filteredVideos, selectedVideo: selectedVideo)
    }
}
