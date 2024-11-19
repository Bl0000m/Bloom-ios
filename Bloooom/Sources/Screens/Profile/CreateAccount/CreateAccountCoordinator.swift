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
    
    func moveToCreateAccount(email: String) {
        let coordinator = VerificationUserCoordinator(navigationController: navigationController, email: email)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func startCountrySelectionFlow(delegate: CountrySelectionDelegate) {
        let countriesCodeVC = CountriesCoordinator(navigationController: navigationController, delegate: delegate)
        countriesCodeVC.start()
    }
}
