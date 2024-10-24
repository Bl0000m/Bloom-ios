import UIKit

class MainScreenCoordinator: Coordinator {
  
  private let navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let mainScreenViewModel = MainScreenViewModel()
    let mainViewController = MainScreenViewController(viewModel: mainScreenViewModel)
    navigationController.pushViewController(mainViewController, animated: true)
  }
}
