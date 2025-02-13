import UIKit

final class BouquestsGalleryCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = BouquestsGalleryViewModel(coordinator: self)
        let viewController = BouquetsGalleryViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToDetails(id: Int, price: Double) {
        let coordinator = BouquetDetailsCoordinator(navigationController: navigationController, id: id, price: price)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func goBack() {
        navigationController.popViewController(animated: true)
    }
}
