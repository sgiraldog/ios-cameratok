import Foundation
import SwiftUI
import AVFoundation
import CoreData

struct VideoInfo {
    var id: String
    var image: UIImage
    var videoUrl: URL?
    var date: Date
    var liked: Bool?
    var coreDataId: NSManagedObjectID?
    
    init(
        id: String,
        image: UIImage,
        videoUrl: URL,
        date: Date,
        liked: Bool?,
        coreDataId: NSManagedObjectID? = nil
    ) {
        self.id = id
        self.image = image
        self.videoUrl = videoUrl
        self.date = date
        self.liked = liked
        self.coreDataId = coreDataId
    }
}
