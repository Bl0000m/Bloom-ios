import UIKit

final class AppCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    private let window: UIWindow
    let navigationController = UINavigationController()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        if let _ = UserDefaults.standard.string(forKey: "userAccessToken") {
            if (KeychainManager.shared.getSavedPin(for: "pinKey") != nil) {
                showPincodeScreen()
            } else {
                showMainScreen()
            }
        } else {
            showMainScreen()
        }
    }

    
    private func showMainScreen() {
        let tabBarCoordinator = MainTabBarCoordinator()
        childCoordinators.append(tabBarCoordinator)
        tabBarCoordinator.start()
        
        window.rootViewController = tabBarCoordinator.tabBarController
        window.makeKeyAndVisible()
    }
    
    private func showPincodeScreen() {
        let pincodeCoordinator = PincodeCoordinator(navigationController: navigationController)
        childCoordinators.append(pincodeCoordinator)
        pincodeCoordinator.start()
        
        window.rootViewController = pincodeCoordinator.navigationController
        window.makeKeyAndVisible()
    }
}
