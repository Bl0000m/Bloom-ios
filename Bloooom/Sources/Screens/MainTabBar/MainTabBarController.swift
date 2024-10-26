import UIKit

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBar()
        navigationController?.isNavigationBarHidden = true
    }
    
    private func configureTabBar() {
        self.tabBar.tintColor = .black
        self.tabBar.barTintColor = .white
    }
}
