import Swinject

class MainScreenModuleAssemble: Assembly {
  func assemble(container: Container) {
    container.register(MainScreenViewModelProtocol.self) { _ in
      MainScreenViewModel()
    }
    container.register(MainScreenViewController.self) { resolver in
      let mainScreenViewModel = resolver.resolve(MainScreenViewModelProtocol.self)
      return MainScreenViewController(viewModel: mainScreenViewModel!)
    }
  }
}
