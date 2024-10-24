import UIKit
import Swinject

class TabBarCoordinator: Coordinator {
  let container: Container
  var tabBarController: UITabBarController
  
  init(container: Container) {
    self.container = container
    self.tabBarController = UITabBarController()
  }
  
  func start() {
    // Разрешаем ViewController через контейнер
    let homeVC = container.resolve(MainScreenViewController.self)!
    let searchVC = container.resolve(SignInViewController.self)!
    let menuVC = container.resolve(CreateAccountViewController.self)!
    let bagVC = container.resolve(MainScreenViewController.self)!
    let profileVC = container.resolve(MainScreenViewController.self)!
    
    // Настраиваем tab bar items
    homeVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "home"), tag: 0)
    searchVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "search"), tag: 1)
    menuVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "menu"), tag: 2)
    bagVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "bag"), tag: 3)
    profileVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "user"), tag: 4)
    
    // Устанавливаем view controllers для tab bar
    tabBarController.viewControllers = [homeVC, searchVC, menuVC, bagVC, profileVC]
    tabBarController.tabBar.tintColor = .black
    tabBarController.tabBar.barTintColor = .white
  }
}
