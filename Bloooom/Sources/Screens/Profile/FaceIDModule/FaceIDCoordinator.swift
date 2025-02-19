import UIKit

final class FaceIDCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = FaceIDViewModel(coordinator: self)
        let viewController = FaceIDViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goPincodeScreen() {
        let coordinator = PincodeCoordinator(navigationController: navigationController)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func moveToWelcome() {
        let page = VerificationViewController(
            model: .success,
            buttonAction: {
                let coordinator = CreatePinCoordinator(navigationController: self.navigationController)
                self.childCoordinators.append(coordinator)
                coordinator.start()
            }
        )
        navigationController.pushViewController(page, animated: true)
    }
}
