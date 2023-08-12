import Foundation
import Photos
import SwiftUI

extension PHAsset {
    func toThumbnail(width: CGFloat, height: CGFloat) -> UIImage? {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail: UIImage?
        option.isSynchronous = true
        manager.requestImage(
            for: self,
            targetSize: CGSize(width: width, height: height),
            contentMode: .aspectFill,
            options: option,
            resultHandler: { (result, info) -> Void in
                thumbnail = result
            }
        )
        return thumbnail
    }
}
