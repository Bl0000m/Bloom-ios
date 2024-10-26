import UIKit

final class SearchViewCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    
    init() {
        self.navigationController = .init()
    }
    
    func start() {
        let viewModel = SearchViewModel(coordinator: self)
        let viewController = SearchViewController(viewModel: viewModel)
        navigationController.viewControllers = [viewController]
    }
}
