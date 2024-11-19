import UIKit

final class CountriesCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    var delegate: CountrySelectionDelegate?
    
    init(navigationController: UINavigationController, delegate: CountrySelectionDelegate?) {
        self.navigationController = navigationController
        self.delegate = delegate
    }
    
    func start() {
        let viewModel = CountriesViewModel(countriesCoordinator: self)
        let viewController = CountriesCodesViewController(countriesViewModel: viewModel)
        viewController.delegate = delegate
        navigationController.present(viewController, animated: true)
    }
}
