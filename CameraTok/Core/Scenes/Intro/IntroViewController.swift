import UIKit
import SwiftUI

class IntroViewController: UIHostingController<IntroView> {
    init(coordinator: IntroCoordinator) {
        super.init(rootView: IntroView(coordinator: coordinator))
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
