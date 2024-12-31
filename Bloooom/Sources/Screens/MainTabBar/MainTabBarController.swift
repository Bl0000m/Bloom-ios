import UIKit

final class MainTabBarController: UITabBarController {
    private let topBorderLayer = CALayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBar()
        navigationController?.isNavigationBarHidden = true
    }
    
    private func configureTabBar() {
        self.tabBar.tintColor = .black
        self.tabBar.barTintColor = .white
        
        topBorderLayer.name = "topBorder"
        topBorderLayer.frame = CGRect(x: 0, y: 0, width: tabBar.frame.size.width, height: 1)
        topBorderLayer.backgroundColor = UIColor.black.cgColor
        tabBar.layer.addSublayer(topBorderLayer)
    }
}
