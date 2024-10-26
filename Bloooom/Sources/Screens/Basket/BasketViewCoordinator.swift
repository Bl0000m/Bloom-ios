import UIKit

final class BasketViewCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    
    init() {
        self.navigationController = .init()
    }
    
    func start() {
        let viewModel = BasketViewModel(coordinator: self)
        let viewController = BasketViewController(viewModel: viewModel)
        navigationController.viewControllers = [viewController]
    }
}
