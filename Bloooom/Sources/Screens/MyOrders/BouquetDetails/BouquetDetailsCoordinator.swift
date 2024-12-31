import UIKit

final class BouquetDetailsCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    let id: Int
    
    init(navigationController: UINavigationController, id: Int) {
        self.navigationController = navigationController
        self.id = id
    }
    
    func start() {
        let viewModel = BouquetDetailsViewModel(coordinator: self)
        let viewController = BouquetDetailsViewController(viewModel: viewModel, id: id)
        navigationController.pushViewController(viewController, animated: true)
    }
}
