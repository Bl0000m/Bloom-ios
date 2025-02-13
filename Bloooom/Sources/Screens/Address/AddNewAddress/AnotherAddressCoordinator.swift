import UIKit


final class AnotherAddressCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    let id: Int
    
    
    init(navigationController: UINavigationController, id: Int) {
        self.navigationController = navigationController
        self.id = id
    }
    
    
    func start() {
        let viewModel = AnotherAddressViewModel(coordinator: self)
        let viewController = AnotherAddressViewController(viewModel: viewModel, id: id)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func startCountrySelectionFlow(delegate: CountrySelectionDelegate) {
        let countriesCodeVC = CountriesCoordinator(navigationController: navigationController, delegate: delegate)
        countriesCodeVC.start()
    }
    
    func goToDetailOrder() {
        let viewControllers = navigationController.viewControllers
        if viewControllers.count >= 3 {
            navigationController.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
        } else {
            navigationController.popToRootViewController(animated: true)
        }
    }
}
