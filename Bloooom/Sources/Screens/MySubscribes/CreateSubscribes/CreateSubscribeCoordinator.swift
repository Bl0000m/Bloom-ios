import UIKit

final class CreateSubscribeCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = CreateSubscribeViewModel(coordinator: self)
        let viewController = CreateSubscribeViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func moveBack() {
        navigationController.popViewController(animated: true)
    }
    
    func createSubscribe(subscribeName: String, subscribeType: String) {
        let coordinator = CalendarCoordinator(
            navigationController: navigationController,
            subscribeName: subscribeName,
            subscribeType: subscribeType
        )
        
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}

