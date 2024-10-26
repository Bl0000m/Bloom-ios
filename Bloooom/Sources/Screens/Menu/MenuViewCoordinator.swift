import UIKit

final class MenuViewCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    
    init() {
        self.navigationController = .init()
    }
    
    func start() {
        let viewModel = MenuViewModel(coordinator: self)
        let viewController = MenuViewController(viewModel: viewModel)
        navigationController.viewControllers = [viewController]
    }
}
