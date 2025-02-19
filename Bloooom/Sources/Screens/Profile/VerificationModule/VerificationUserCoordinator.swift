import UIKit

final class VerificationUserCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    var email: String
    
    init(navigationController: UINavigationController, email: String) {
        self.navigationController = navigationController
        self.email = email
    }
    
    func start() {
        let viewModel = VerificationUserViewModel(verificationUserCoordinator: self)
        let viewController = VerificationUserViewController(viewModel: viewModel, email: email)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func backButtonAction() {
        navigationController.popViewController(animated: true)
    }
    
    func successVerification() {
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
