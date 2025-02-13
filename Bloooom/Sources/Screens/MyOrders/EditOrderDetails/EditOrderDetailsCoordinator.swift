import UIKit

final class EditOrderDetailsCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    let id: Int
    let branchId: Int
    
    init(navigationController: UINavigationController, id: Int, branchId: Int) {
        self.navigationController = navigationController
        self.id = id
        self.branchId = branchId
    }
    
    func start() {
        let viewModel = EditOrderDetailsViewModel(coordinator: self)
        let viewController = EditOrderDetailsViewController(viewModel: viewModel, id: id)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToAddress() {
        let coordinator = UserAddressCoordinator(navigationController: navigationController, id: id)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func goToOrdersList() {
        let viewControllers = navigationController.viewControllers
        if viewControllers.count >= 6 {
            navigationController.popToViewController(viewControllers[viewControllers.count - 6], animated: true)
        } else {
            navigationController.popToRootViewController(animated: true)
        }
    }
}
