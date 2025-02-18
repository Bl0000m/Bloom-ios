import UIKit

final class ConfrimPasswordCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    private let email: String
    
    init(navigationController:  UINavigationController, email: String) {
        self.navigationController = navigationController
        self.email = email
    }
    
    func start() {
        let viewModel = ConfirmPasswordViewModel(coordinator: self)
        let viewController = ConfirmPasswordViewController(viewModel: viewModel, email: email)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToMain() {
        let successView = VerificationViewController(
            model: .passwordChanged) { [weak self] in
                let coordinator = MainTabBarCoordinator(navigationController: self!.navigationController)
                self?.childCoordinators.append(coordinator)
                coordinator.start()
                
                self?.navigationController.pushViewController(
                    coordinator.tabBarController,
                    animated: true
                )
            }
        successView.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(successView, animated: true)
    }
    
}
