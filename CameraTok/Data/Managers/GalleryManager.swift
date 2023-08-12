import Foundation
import Photos

class GalleryManager {
    static let shared = GalleryManager()
    
    func fetchVideos(before date: Date, limit: Int = 15) -> [PHAsset] {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        fetchOptions.predicate = NSPredicate(format: "creationDate < %@", date as CVarArg)
        fetchOptions.fetchLimit = limit
        
        let fetchResult = PHAsset.fetchAssets(with: .video, options: fetchOptions)
        return fetchResult.objects(at: IndexSet(0..<min(fetchResult.count, limit)))
    }
    
    func requestGalleryPermissions(completion: @escaping (Bool) -> Void) {
         let status = PHPhotoLibrary.authorizationStatus()
         switch status {
         case .authorized:
             completion(true)
         case .notDetermined:
             PHPhotoLibrary.requestAuthorization { newStatus in
                 if newStatus == .authorized {
                     DispatchQueue.main.async {
                         completion(true)
                     }
                 } else {
                     completion(false)
                 }
             }
         default:
             completion(false)
             break
         }
     }
}
