import UIKit

class AppCoordinator: Coordinator {
    let window: UIWindow
    
    var videosCoordinator: VideosCoordinator?
    var introCoordinator: IntroCoordinator?
    
    var rootViewController: UIViewController? {
        let isIntroPresented = PreferencesManager.shared.isIntroPresented()
        return isIntroPresented ? videosCoordinator?.navigationController : introCoordinator?.navigationController
    }
    
    init(window: UIWindow) {
        self.window = window
        
    }
    
    func start() {
        introCoordinator = makeIntroCoordinator()
        introCoordinator?.start()
        introCoordinator?.delegate = self
        
        videosCoordinator = makeVideosCoordinator()
        videosCoordinator?.start()
        
        window.rootViewController = rootViewController
    }
}

extension AppCoordinator {
    func makeIntroCoordinator() -> IntroCoordinator {
        let coordinator = IntroCoordinator()
        return coordinator
    }
    
    func makeVideosCoordinator() -> VideosCoordinator {
        let coordinator = VideosCoordinator()
        return coordinator
    }
}

extension AppCoordinator: IntroCoordinatorDelegate {
    func didCompleteIntro() {
        introCoordinator = nil
        window.rootViewController = rootViewController
    }
}
