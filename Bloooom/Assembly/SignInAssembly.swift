import Swinject

class SignInModuleAssembly: Assembly {
  func assemble(container: Container) {
    container.register(SignInViewModelProtocol.self) { _ in
      SignInViewModel()
    }
    container.register(SignInViewController.self) { resolver in
      let signInViewModel = resolver.resolve(SignInViewModelProtocol.self)!
      let signInCoordinator = resolver.resolve(SignInCoordinator.self)!
      return SignInViewController(signInViewModel: signInViewModel, signInCoordinator: signInCoordinator)
    }
  }
}

