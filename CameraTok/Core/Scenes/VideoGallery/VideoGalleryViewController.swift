import UIKit
import SwiftUI

class VideoGalleryViewController: UIHostingController<VideoGalleryView> {
    init(coordinator: VideosCoordinator) {
        super.init(rootView: VideoGalleryView(coordinator: coordinator))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        navigationController?.isNavigationBarHidden = false
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
