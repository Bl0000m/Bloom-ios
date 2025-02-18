import UIKit

final class PincodeCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.isNavigationBarHidden = true
    }
    
    func start() {
        let viewModel = PincodeViewModel(coordinator: self)
        let viewController = PincodeViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goForgotPassword() {
        let coordinator = ForgotPinPasswordCoordinator(navigationController: navigationController)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func moveToMain() {
        let coordinator = MainTabBarCoordinator(navigationController: navigationController)
        childCoordinators.append(coordinator)
        coordinator.start()
        coordinator.tabBarController.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(
            coordinator.tabBarController,
            animated: true
        )
    }
    
}
