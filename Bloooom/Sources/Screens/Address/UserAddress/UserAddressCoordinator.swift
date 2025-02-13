import UIKit

final class UserAddressCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    let id: Int
    
    init(navigationController: UINavigationController, id: Int) {
        self.navigationController = navigationController
        self.id = id
    }
    
    func start() {
        let viewModel = UserAddressViewModel(coordinator: self)
        let viewController = UserAddressViewController(viewModel: viewModel, id: id)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToAnotherAddress() {
        let coordinator = AnotherAddressCoordinator(navigationController: navigationController, id: id)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    
}
