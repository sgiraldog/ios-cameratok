import Foundation
import Photos
import Combine
import CoreData

class VideoService {
    func getVideos(before date: Date, width: CGFloat) -> AnyPublisher<[VideoInfo], Never> {
        let videoAssets = GalleryManager.shared.fetchVideos(before: date)
        let storedVideos = CoreDataManager.shared.fetchVideos()

        return Publishers.MergeMany(videoAssets.map { asset in
            asset.toVideoURL()
                .compactMap { videoUrl -> VideoInfo? in
                    let storedVideo = storedVideos.first(where: { $0.id == asset.localIdentifier })
                    guard storedVideo?.liked != false,
                          let videoUrl = videoUrl,
                          let image = asset.toThumbnail(width: width, height: width * 2)
                    else {
                        return nil
                    }
                    return VideoInfo(
                        id: asset.localIdentifier,
                        image: image,
                        videoUrl: videoUrl,
                        date: asset.creationDate ?? .now,
                        liked: storedVideo?.liked,
                        coreDataId: storedVideo?.objectID
                    )
                }
                .eraseToAnyPublisher()
        })
        .collect()
        .eraseToAnyPublisher()
    }
    
    func updateVideoLikeStatus(for video: VideoInfo) {
        guard let liked = video.liked else { return }
        if let id = video.coreDataId {
            CoreDataManager.shared.updateVideo(id: id, liked: liked)
        } else {
            CoreDataManager.shared.createVideo(id: video.id, liked: liked)
        }
    }
    
    func getVideosLikedState() -> [Video] {
        return CoreDataManager.shared.fetchVideos()
    }
}
