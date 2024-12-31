import UIKit

final class MySubscribesCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = MySubscribesViewModel(coordinator: self)
        let viewController = MySubscribesViewController(viewModel: viewModel)
        viewController.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func moveBack() {
        navigationController.popViewController(animated: true)
    }
    
    func createSubscribe() {
        let coordinator = CreateSubscribeCoordinator(navigationController: navigationController)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}
