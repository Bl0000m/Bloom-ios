import Foundation

protocol CreateAccountViewModelProtocol {
    func moveToCreateAccount()
    func backButtonTapped()
}

final class CreateAccountViewModel: CreateAccountViewModelProtocol {
    
    private weak var createAccountCoordinator: CreateAccountCoordinator?
    
    init(createAccountCoordinator: CreateAccountCoordinator?) {
        self.createAccountCoordinator = createAccountCoordinator
    }
    
    func backButtonTapped() {
        createAccountCoordinator?.moveToBack()
    }
    func moveToCreateAccount() {
        createAccountCoordinator?.moveToCreateAccount()
    }
}
