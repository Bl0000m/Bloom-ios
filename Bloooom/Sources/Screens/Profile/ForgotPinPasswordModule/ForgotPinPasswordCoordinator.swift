import UIKit

final class ForgotPinPasswordCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = ForgotPinPasswordViewModel(coordinator: self)
        let viewController = ForgotPinPasswordViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goBack() {
        navigationController.popViewController(animated: true)
    }
    
    func checkEmailCode(email: String) {
        let coordinator = CheckEmailCoordinator(navigationController: navigationController, email: email)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
}
