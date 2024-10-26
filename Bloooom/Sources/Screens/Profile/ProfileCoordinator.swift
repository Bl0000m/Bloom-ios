import UIKit

final class ProfileCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    
    init() {
        self.navigationController = .init()
    }
    
    func start() {
        let viewModel = SignInViewModel(coordinator: self)
        let viewController = SignInViewController(viewModel: viewModel)
        navigationController.viewControllers = [viewController]
    }
    
    func backButtonTapped() {
        if let tabBarController = navigationController.tabBarController {
            tabBarController.selectedIndex = Tab.home.rawValue
        }
    }
    
    func moveToCreateAccount() {
        let viewModel = CreateAccountViewModel()
        let viewController = CreateAccountViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func forgotPasswordTapped() {}
    func moveToAccount() {}
}
