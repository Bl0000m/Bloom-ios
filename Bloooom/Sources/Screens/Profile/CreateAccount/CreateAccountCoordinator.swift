import UIKit

final class CreateAccountCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = CreateAccountViewModel(createAccountCoordinator: self)
        let viewController = CreateAccountViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func moveToMainPage() {
        let page = VerificationViewController(
            model: .success,
            buttonAction: {
                
            }
        )
        navigationController.pushViewController(page, animated: true)
    }
    
    func moveToBack() {
        navigationController.popViewController(animated: true)
    }
    
    func moveToCreateAccount() {
        let createViewController = FormViewController(
            model: .emailVerification,
            buttonAction: { [weak self] in
                self?.moveToMainPage()
            },
            backButtonAction: { [weak self] in
                self?.navigationController.popViewController(animated: true)
            })
        navigationController.pushViewController(createViewController, animated: true)
    }
}
