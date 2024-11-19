import UIKit

protocol CheckEmailViewModelProtocol {
    func confirmCode(email: String, code: String)
    func goToConfirmCode()
    func moveBack()
    var onCodeConfirmed: (() -> Void)? { get set }
    var onError: ((String) -> Void)? { get set }
}

class CheckEmailViewModel: CheckEmailViewModelProtocol {
    
    var onError: ((String) -> Void)?
    var onCodeConfirmed: (() -> Void)?
    
    let coordinator: CheckEmailCoordinator
    
    init(coordinator: CheckEmailCoordinator) {
        self.coordinator = coordinator
    }
    
    func confirmCode(email: String, code: String) {
        UserAPIManager.shared.confirmCode(email: email, code: code) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.onCodeConfirmed?()
                case .failure(let error):
                    self?.onError?(error.localizedDescription)
                }
            }
        }
    }
    
    func goToConfirmCode() {
        coordinator.moveToConfirmCode()
    }
    
    func moveBack() {
        coordinator.moveToBack()
    }
}


