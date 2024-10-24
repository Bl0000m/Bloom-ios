import Swinject

class CreateAccountAssembly: Assembly {
  func assemble(container: Container) {
    container.register(CreateAccountViewModelProtocol.self) { _ in CreateAccountViewModel() }
    
    container.register(CreateAccountViewController.self) { resolver in
      let viewModel = resolver.resolve(CreateAccountViewModelProtocol.self)!
      let coordinator = resolver.resolve(CreateAccountCoordinator.self)!
      return CreateAccountViewController(createAccountViewModel: viewModel, createAccountCoordinator: coordinator)
    }
  }
}
