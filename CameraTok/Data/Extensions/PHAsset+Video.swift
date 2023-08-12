import Foundation
import Photos
import Combine
import AVKit

extension PHAsset {
    func toVideoURL() -> Future<URL?, Never> {
        return Future { promise in
            guard self.mediaType == .video else {
                promise(.success(nil))
                return
            }
            
            PHCachingImageManager().requestAVAsset(forVideo: self, options: nil) { avAsset, _, _ in
                if let urlAsset = avAsset as? AVURLAsset {
                    let localVideoUrl: URL = urlAsset.url as URL
                    promise(.success(localVideoUrl))
                } else {
                    promise(.success(nil))
                }
            }
        }
    }
}
