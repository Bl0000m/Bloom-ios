import Swinject
import UIKit

class TabBarAssembly {
  static func registerDependencies(in container: Container) {
    container.register(MainScreenViewModelProtocol.self) { _ in MainScreenViewModel() }
    
    container.register(MainScreenViewController.self) { resolver in
      let viewModel = resolver.resolve(MainScreenViewModelProtocol.self)!
      return MainScreenViewController(viewModel: viewModel)
    }
    
    container.register(SignInViewModelProtocol.self) { _ in SignInViewModel() }
    
    container.register(UINavigationController.self) { _ in UINavigationController() }
    
    container.register(SignInCoordinator.self) { resolver in
      let navigatioController = resolver.resolve(UINavigationController.self)!
      return SignInCoordinator(navigationController: navigatioController) }
    
    container.register(SignInViewController.self) { resolver in
      let viewModel = resolver.resolve(SignInViewModelProtocol.self)!
      let coordinator = resolver.resolve(SignInCoordinator.self)!
      return SignInViewController(signInViewModel: viewModel, signInCoordinator: coordinator)
    }
    
    container.register(CreateAccountViewModelProtocol.self) { _ in CreateAccountViewModel() }
    
    container.register(CreateAccountCoordinator.self) { resolver in
      let navigationController = resolver.resolve(UINavigationController.self)!
      return CreateAccountCoordinator(navigationController: navigationController)
    }
    
    container.register(CreateAccountViewController.self) { resolver in
      let viewModel = resolver.resolve(CreateAccountViewModelProtocol.self)!
      let coordinator = resolver.resolve(CreateAccountCoordinator.self)!
      return CreateAccountViewController(createAccountViewModel: viewModel, createAccountCoordinator: coordinator)
    }
    
    container.register(UIViewController.self, name: "Bag") { _ in UIViewController() }
    container.register(UIViewController.self, name: "Profile") { _ in UIViewController() }
  }
}
