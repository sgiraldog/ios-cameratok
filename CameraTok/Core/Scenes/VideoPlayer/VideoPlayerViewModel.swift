import Foundation
import AVKit

class VideoPlayerViewModel: ObservableObject {
    private let coordinator: VideosCoordinator
    private let service = VideoService()
    
    @Published var videos: [VideoInfo]
    @Published var currentVideoIndex: Int
    @Published var players: [AVPlayer?]
    @Published var currentVideoProgress: Float = 0.0
    @Published var blockVideoPlayback: Bool = false
    @Published var showControls: Bool = false
    @Published var isMuted: Bool = false
    
    private var timeObservers: [Int: Any] = [:]
    
    init(
        coordinator: VideosCoordinator,
        videos: [VideoInfo],
        selectedVideo: Int = 0
    ) {
        self.coordinator = coordinator
        self.videos = videos
        self.players = [AVPlayer](repeating: .init(), count: videos.count)
        self.currentVideoIndex = selectedVideo
    }
    
    func onAppear() {
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: nil, queue: .main) { [weak self] _ in
            guard let self = self else { return }
            self.restartPlayer(at: self.currentVideoIndex)
        }
    }
    
    func onDisappear() {
        NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    func startPlayer(at index: Int) {
        if let videoUrl = videos[index].videoUrl {
            players[index] = AVPlayer(url: videoUrl)
            setupProgressObserver()
            players[index]?.play()
            players[index]?.isMuted = isMuted
        }
    }
    
    func restartPlayer(at index: Int) {
        players[index]?.seek(to: .zero)
        players[index]?.play()
        setupProgressObserver()
    }
    
    func stopPlayer(at index: Int) {
        if let token = timeObservers[index] {
            players[index]?.removeTimeObserver(token)
            timeObservers[index] = nil
        }
        players[index]?.pause()
        players[index] = nil
    }
    
    func goBack() {
        coordinator.popCurrentScene()
    }
    
    func setupProgressObserver() {
        guard let player = players[currentVideoIndex] else { return }
        
        if let timeObserver = timeObservers[currentVideoIndex] {
            player.removeTimeObserver(timeObserver)
            timeObservers[currentVideoIndex] = nil
        }
        
        timeObservers[currentVideoIndex] = player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1), queue: .main) { [weak self] _ in
            if let duration = player.currentItem?.duration.seconds {
                self?.currentVideoProgress = Float(player.currentTime().seconds / duration)
            }
        }
    }
    
    func sliderDidUpdatePlayback() {
        guard let player = players[currentVideoIndex] else { return }
        if blockVideoPlayback {
            player.pause()
        } else {
            updateVideoProgress()
        }
    }
    
    private func updateVideoProgress() {
        guard let player = players[currentVideoIndex], let duration = player.currentItem?.duration.seconds else { return }
        let seconds = Double(currentVideoProgress * Float(duration))
        player.seek(to: CMTime(seconds: seconds, preferredTimescale: 1))
        player.play()
    }
    
    func updateVideoLikeStatus(for index: Int, liked: Bool) {
        videos[index].liked = liked
        service.updateVideoLikeStatus(for: videos[index])
    }
    
    func updateMuteStatus() {
        isMuted.toggle()
        players[currentVideoIndex]?.isMuted = isMuted
    }
}
