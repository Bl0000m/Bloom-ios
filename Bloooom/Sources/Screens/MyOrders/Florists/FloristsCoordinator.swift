import UIKit

final class FloristsCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    let id: Int
    
    init(navigationController: UINavigationController, id: Int) {
        self.navigationController = navigationController
        self.id = id
    }
    
    func start() {
        let viewModel = FloristsViewModel(coordinator: self)
        let viewController = FloristsViewController(viewModel: viewModel, id: id)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goBack() {
        navigationController.popViewController(animated: true)
    }
    
    func selectedFlorists(bouquetId: Int, branchId: Int) {
        let coordinator = EditOrderDetailsCoordinator(navigationController: navigationController, id: bouquetId, branchId: branchId)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}
