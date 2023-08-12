import UIKit

protocol IntroCoordinatorDelegate: AnyObject {
    func didCompleteIntro()
}

class IntroCoordinator: NavigatedCoordinator {
    var navigationController: UINavigationController
    
    weak var delegate: IntroCoordinatorDelegate?
    
    init() {
        navigationController = .init()
    }
    
    func start() {
        let rootViewController = IntroViewController(coordinator: self)
        navigationController.setViewControllers([rootViewController], animated: false)
    }
    
    func complete() {
        delegate?.didCompleteIntro()
    }
}
