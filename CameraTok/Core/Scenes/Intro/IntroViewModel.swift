import Foundation

class IntroViewModel: ObservableObject {
    private let coordinator: IntroCoordinator
    @Published var permissionsDenied = false
    
    init(coordinator: IntroCoordinator) {
        self.coordinator = coordinator
    }
    
    func completeIntro() {
        GalleryManager.shared.requestGalleryPermissions { [weak self] granted in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if granted {
                    PreferencesManager.shared.setIntroPresented()
                    self.coordinator.complete()
                } else {
                    self.permissionsDenied = true
                }
            }
        }
    }
}
