import UIKit

final class ProfileCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    
    init() {
        self.navigationController = .init()
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
        let newPasswordCreation = FormViewController(
            model: .newPasswordCreation,
            buttonAction: { [weak self] in
                self?.verifyPassword()
            },
            backButtonAction: { [weak self] in
                self?.navigationController.popViewController(animated: true)
            })
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
        let forgotViewController = FormViewController(
            model: .passwordReset,
            buttonAction: { [weak self] in
                self?.moveToVerifyEmail()
            },
            backButtonAction: { [weak self] in
                self?.navigationController.popViewController(animated: true)
            })
        
        navigationController.pushViewController(forgotViewController, animated: true)
    }
    
    func moveToAccount() {}
}
