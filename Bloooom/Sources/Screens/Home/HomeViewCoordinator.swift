import UIKit

class HomeViewCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    
    init() {
        self.navigationController = .init()
    }
    
    func start() {
        let viewModel = HomeViewModel(mainScreenCoordinator: self)
        let viewController = HomeViewController(viewModel: viewModel)
        navigationController.viewControllers = [viewController]
    }
}
