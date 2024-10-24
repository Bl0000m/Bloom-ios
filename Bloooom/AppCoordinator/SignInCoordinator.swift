import UIKit

class SignInCoordinator: Coordinator {
  
  private let navigationController: UINavigationController
  private var createAccontCoordinator: CreateAccountCoordinator!
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let signInViewModel = SignInViewModel()
    let signInCoordinator = self
    let signInViewController = SignInViewController(signInViewModel: signInViewModel, signInCoordinator: signInCoordinator)
    navigationController.pushViewController(signInViewController, animated: true)
  }
  
  func backButtonTapped() {
    print("Don't worry, be happy")
  }
  
  func forgorPasswordTapped() {
    print("Forgot Password")
  }
  
  func moveToAccount() {
    print("Move to Account")
  }
  
  func moveToCreateAccount() {
    print("Move to create account")
    createAccontCoordinator = CreateAccountCoordinator(navigationController: navigationController)
    createAccontCoordinator.start()
  }
}
