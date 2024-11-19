import UIKit

final class CreatePinCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = PinViewModel(coordinator: self)
        let viewController = CreatePinViewController(viewModel: viewModel)
        viewController.hidesBottomBarWhenPushed = true
        navigationController.viewControllers = [viewController]
    }
    
    func goToFaceId() {
        let coordinator = FaceIDCoordinator(navigationController: navigationController)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func goBack() {
        
    }
    
    func close() {
        
    }
}
