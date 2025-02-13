import UIKit

final class BouquetDetailsCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    let id: Int
    let price: Double
    
    init(navigationController: UINavigationController, id: Int, price: Double) {
        self.navigationController = navigationController
        self.id = id
        self.price = price
    }
    
    func start() {
        let viewModel = BouquetDetailsViewModel(coordinator: self)
        let viewController = BouquetDetailsViewController(viewModel: viewModel, id: id, price: price)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goBack() {
        navigationController.popViewController(animated: true)
    }
    
    func goToFlorists(id: Int) {
        let coorditor = FloristsCoordinator(navigationController: navigationController, id: id)
        childCoordinators.append(coorditor)
        coorditor.start()
    }
}
