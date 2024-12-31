import UIKit

final class MonthsCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = MonthsViewModel(coordinator: self)
        let viewController = MonthsViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
