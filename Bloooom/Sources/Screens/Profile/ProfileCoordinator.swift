import UIKit

final class ProfileCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = SignInViewModel(coordinator: self)
        let viewController = SignInViewController(viewModel: viewModel)
        viewController.hidesBottomBarWhenPushed = true
        navigationController.viewControllers = [viewController]
    }
    
    private func moveToVerifyEmail() {
        let confirmEmail = FormViewController(
            model: .emailVerification,
            buttonAction: { [weak self] in
                self?.newPasswordCreation()
            },
            backButtonAction: { [weak self] in
                self?.navigationController.popViewController(animated: true)
            }
        )
        navigationController.pushViewController(confirmEmail, animated: true)
    }
    
    private func newPasswordCreation() {
        let newPasswordCreation = UIViewController()
        navigationController.pushViewController(newPasswordCreation, animated: true)
    }
    
    private func verifyPassword() {
        let verifyView = VerificationViewController(
            model: .passwordChanged,
            buttonAction: {
                
            }
        )
        navigationController.pushViewController(verifyView, animated: true)
    }
    
    func backButtonTapped() {
        if let tabBarController = navigationController.tabBarController {
            tabBarController.selectedIndex = Tab.home.rawValue
        }
    }
    
    func moveToCreateAccount() {
        let coordinator = CreateAccountCoordinator(navigationController: navigationController)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func forgotPasswordTapped() {
        let coordinator = ForgotPinPasswordCoordinator(navigationController: navigationController)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func moveToAccount() {
        let successView = VerificationViewController(
            model: .success) { [weak self] in
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
