import UIKit

final class DetailsOrderCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    let id: Int
    
    init(navigationController: UINavigationController, id: Int) {
        self.navigationController = navigationController
        self.id = id
    }
    
    func start() {
        let viewModel = DetailsOrderViewModel(coordinator: self)
        let viewController = DetailsOrderViewController(viewModel: viewModel, id: id)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func moveToGallery() {
        let coordinator = BouquestsGalleryCoordinator(navigationController: navigationController)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func moveToOrderList() {
        let viewControllers = navigationController.viewControllers
        if viewControllers.count >= 2 {
            navigationController.popToViewController(viewControllers[viewControllers.count - 2], animated: true)
        } else {
            navigationController.popToRootViewController(animated: true)
        }
    }
}
