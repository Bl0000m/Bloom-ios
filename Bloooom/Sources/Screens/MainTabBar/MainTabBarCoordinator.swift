import UIKit

final class MainTabBarCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    let tabBarController: UITabBarController
    
    init() {
        self.tabBarController = MainTabBarController()
    }
    
    func start() {
        childCoordinators = [
            HomeViewCoordinator(), SearchViewCoordinator(), MenuViewCoordinator(),
            BasketViewCoordinator(), ProfileCoordinator()
        ]
        
        setupTabControllers()
    }
    
    private func setupTabControllers() {
        tabBarController.viewControllers = childCoordinators.map { coordinator in
            coordinator.start()
            
            if let tabView = coordinator.navigationController.viewControllers.first as? TabView {
                coordinator.navigationController.tabBarItem = UITabBarItem(
                    title: nil,
                    image: UIImage(named: tabView.tabInfo.image),
                    tag: tabView.tabInfo.rawValue
                )
            }
            
            
            return coordinator.navigationController
        }
    }
}
