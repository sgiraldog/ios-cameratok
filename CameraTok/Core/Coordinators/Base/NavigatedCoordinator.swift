import UIKit

protocol NavigatedCoordinator: Coordinator {
    var navigationController: UINavigationController { get set }
}

extension NavigatedCoordinator {
    func popCurrentScene(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }
    
    func popToRootScene(animated: Bool = true) {
        navigationController.popToRootViewController(animated: animated)
    }
}
