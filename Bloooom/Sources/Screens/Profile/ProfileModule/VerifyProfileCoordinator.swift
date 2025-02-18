import UIKit


final class VerifyProfileCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    
    init() {
        self.navigationController = .init()
    }
    
    func start() {
        let viewModel = VerifyProfileViewModel(coordinator: self)
        let viewController = VerifyProfileViewController(viewModel: viewModel)
        navigationController.viewControllers = [viewController]
    }
    
    func goToSubscribes() {
        let coordinator = MySubscribesCoordinator(navigationController: navigationController)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func goToSignIn() {
        let coordinator = ProfileCoordinator(navigationController: navigationController)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
}
