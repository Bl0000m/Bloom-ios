import UIKit

final class CheckEmailCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    let email: String
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController, email: String) {
        self.navigationController = navigationController
        self.email = email
    }
    
    func start() {
        let viewModel = CheckEmailViewModel(coordinator: self)
        let viewController = CheckEmailViewController(viewModel: viewModel, email: email)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func moveToConfirmCode() {
        let coordinator = ConfrimPasswordCoordinator(navigationController: navigationController, email: email)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func moveToBack() {
        navigationController.popViewController(animated: true)
    }
}

