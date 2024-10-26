import Foundation

protocol SignInViewModelProtocol {
    func moveToAccount()
    func moveToCreateAccount()
    func backButtonTapped()
    func forgotPasswordTapped()
}

final class SignInViewModel: SignInViewModelProtocol {
    private weak var coordinator: ProfileCoordinator?
    
    init(coordinator: ProfileCoordinator?) {
        self.coordinator = coordinator
    }
    
    func moveToAccount() {
        coordinator?.moveToAccount()
    }
    
    func moveToCreateAccount() {
        coordinator?.moveToCreateAccount()
    }
    
    func backButtonTapped() {
        coordinator?.backButtonTapped()
    }
    
    func forgotPasswordTapped() {
        coordinator?.forgotPasswordTapped()
    }
}
