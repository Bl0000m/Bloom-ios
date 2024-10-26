import Swinject
import UIKit

class CreateAccountAssembly: Assembly {
  func assemble(container: Container) {
    container.register(CreateAccountViewModelProtocol.self) { _ in CreateAccountViewModel() }
    
    container.register(UINavigationController.self) { _ in UINavigationController() }
    
    container.register(CreateAccountCoordinator.self) { resolver in
      let navigationController = resolver.resolve(UINavigationController.self)!
      return CreateAccountCoordinator(navigationController: navigationController)
    }
    
    container.register(CreateAccountViewController.self) { resolver in
      let viewModel = resolver.resolve(CreateAccountViewModelProtocol.self)!
      let coordinator = resolver.resolve(CreateAccountCoordinator.self)!
      return CreateAccountViewController(createAccountViewModel: viewModel, createAccountCoordinator: coordinator)
    }
  }
}
