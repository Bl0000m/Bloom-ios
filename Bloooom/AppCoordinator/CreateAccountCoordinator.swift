import UIKit

class CreateAccountCoordinator: Coordinator {
  
  private let navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let viewModel = CreateAccountViewModel()
    let coordinator = self
    let createViewController = CreateAccountViewController(createAccountViewModel: viewModel, createAccountCoordinator: coordinator)
    navigationController.pushViewController(createViewController, animated: true)
  }
}
