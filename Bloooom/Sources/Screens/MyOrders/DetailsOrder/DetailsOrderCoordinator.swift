import UIKit

final class DetailsOrderCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = DetailsOrderViewModel(coordinator: self)
        let viewController = DetailsOrderViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func moveToGallery() {
        let coordinator = BouquestsGalleryCoordinator(navigationController: navigationController)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}
