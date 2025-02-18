import UIKit

final class OrderDetailsCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    let monthNames: [Date]
    let subsrcibeName: String
    let subscribeType: String
    
    init(navigationController: UINavigationController, monthNames: [Date], subsrcibeName: String, subscribeType: String) {
        self.navigationController = navigationController
        self.subsrcibeName = subsrcibeName
        self.subscribeType = subscribeType
        self.monthNames = monthNames
    }
    
    func start() {
        let viewModel = OrderDetailsViewModel(coordinator: self)
        let viewController = OrederDetailsViewController(viewModel: viewModel, monthNames: monthNames)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func popToPreviousScreen(steps: Int = 3) {
           guard steps > 0 else { return }
           let targetIndex = navigationController.viewControllers.count - steps - 1
           if targetIndex >= 0, targetIndex < navigationController.viewControllers.count {
               let targetViewController = navigationController.viewControllers[targetIndex]
               navigationController.popToViewController(targetViewController, animated: true)
           } else {
               navigationController.popToRootViewController(animated: true)
           }
       }
    
    func moveToOrderDetails(id: Int) {
        let coordinator = DetailsOrderCoordinator(navigationController: navigationController, id: id)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}
