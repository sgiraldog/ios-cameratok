import Foundation
import CoreData

extension CoreDataManager {
    func fetchVideos() -> [Video] {
        let request = Video.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            return []
        }
    }
    
    func createVideo(id: String, liked: Bool) {
        let video = Video(context: context)
        video.id = id
        video.liked = liked
        saveContext()
    }
    
    func updateVideo(id: NSManagedObjectID, liked: Bool) {
        if let video = context.object(with: id) as? Video {
            video.liked = liked
            saveContext()
        }
    }
}
